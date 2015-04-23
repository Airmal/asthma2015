class PurchasesController < ApplicationController
  
  # 请购邀请码
  def create
    @purchase = Purchase.new
    @purchase.admin_id = current_admin.id
    @purchase.program_id = params[:program_id]
    @purchase.num_purchase = params[:num_purchase]
    @purchase.purchase_flg = Purchase::STATE[:purchased]

    @program = Program.find(params[:program_id])
    @program.enroll_num += @purchase.num_purchase

    # ActiveRecord::Base.transaction do
      params[:num_purchase].to_i.times do | i |
        @appointment = Appointment.create(
        	:program_id => params[:program_id],
        	:state => Appointment::STATE[:normal])
      end

      respond_to do |format|

        if @purchase.save && @program.save
          format.json { render json: {'id'=>@purchase.id}}
        else
          format.json { render json: @purchase.errors || @program.errors, :status => 400 }
        end
      end
    # end
  end

  # 审核通过请购
  def commit
    @purchase = Purchase.find(params[:purchase_id])
    @purchase.purchase_flg = Purchase::STATE[:normal]

      respond_to do |format|
        if @purchase.save
          format.json { render json: {'id'=>@purchase.id}}
        else
          format.json { render json: @purchase.errors, :status => 400 }
        end
      end
  end


end