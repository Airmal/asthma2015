class SmsController < ApplicationController
  def send_sms
    sms_info = SmartSMS.find start_time: Time.now - 1.minute, end_time: Time.now, mobile: params[:mobile]

    respond_to do |format|
      if sms_info.has_key? "sms" && sms_info["sms"].first.present? && sms_info["sms"].first["send_status"] == "SUCCESS"
        format.json { render json: { :msg => '短信获取过于频繁' }, :status => :ok }
      else
        sms_code = SmartSMS::VerificationCode.random :short
        SmartSMS.deliver params[:mobile], sms_code
        format.json { render json: { :msg => '信息已发送' }, :status => :ok }
      end
    end
  end

  def check_sms
    latest_message = SmartSMS.find mobile: params[:mobile]
    sms_info = latest_message['sms'].first || 0
    expect_code = sms_info["text"].gsub(/(【.+】|[^a-zA-Z0-9\.\-\+_])/, '')
    respond_to do |format|
      if expect_code == params[:sms_code]
        format.json { render json: { :result => 'success' } }
      else
        format.json { render json: { :result => 'failure' } }
      end
    end
  end
end
