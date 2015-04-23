class InvitatesController < ApplicationController

  def check_invitatecode

    # 邀请码不为空
    if !params[:invitatecode].nil?
      invitate = Invitate.find_by invitate_cd: params[:invitatecode]
    end
    respond_to do |format|
      # 未找到记录 或者 邀请码flg <> 1(已发放未使用)
      if invitate.nil? || invitate.invitate_flg != 1
        format.json { render json: { :result => 'failure' } }
      else  
        format.json { render json: { :result => 'success' } }
      end
    end
  end
end
