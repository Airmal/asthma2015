class ProgramsController < ApplicationController
  require 'action_view'
  include ActionView::Helpers::DateHelper

  before_action :require_user_login, :only => [:appoint, :unappoint, :quiz, :comment, :my_comment, :save_interactive]

  # def initialize_session
  #   # perform application setup here
  #   controller_store[:current_page] = 1
  # end
  
  def index
    # 直播还是录播
    if !params[:liveflg].nil?
      @programs = Program.where(:live_or_replay => params[:liveflg]).page(params[:page])
    end
  end

  def show
    @program = Program.find params[:id]
    # 当前program的星级求和
    @sumrank = Comment.select("id, rank").where("program_id = " + params[:id]).sum("rank")
    # 当前program的件数
    countrank = Comment.where("program_id = " + params[:id]).count
    @avgrankTof = 0
    @avgrank = 0
    if countrank > 0
      # 求平均值（10分为满分）
      @avgrankTof = @sumrank/countrank.to_f * 2
      # 求星级的分数（取整）
      @avgrank = @sumrank/countrank
    end

    # 当前直播program的课件
    flg = Courseware::REMOTE_OR_LOCAL[:remote]
    if @program.live_or_replay == Program::TYPE[:replay]
      flg = Courseware::REMOTE_OR_LOCAL[:local]
    end

    @courseware = Courseware.where(:program_id => params[:id], :remote_or_local => flg).limit 1
    if @courseware.present?
      @courseware = @courseware[0]
    else
      @courseware = Courseware.new
    end

    tmpImgs = Dir.entries("public#{Settings.programs_images_url}#{params[:id]}/")
    @live_images =  Array.new

    Dir.foreach("public#{Settings.programs_images_url}#{params[:id]}/") do |item|
      if item.start_with?("live_") 
        # do work on real items
        @live_images.push("#{Settings.programs_images_url}#{params[:id]}/#{item}")
      end
    end

    # 是否有邀请码
    if !current_user.blank?
      invitate = Invitate.find_by_user_id_and_program_id current_user.id, params[:id]
      if !invitate.nil?
        @invitate_cd = invitate.invitate_cd
      end
    end

    # 互动
    @interactives = Interactive.where(:program_id => params[:id])
  end

  def appoint
    @appointment = Appointment.find_by_user_id_and_program_id current_user.id, params[:id]

    respond_to do |format|

      if params[:invitate_cd].nil?
        # 预约人数＋1
        @program = Program.find(params[:id])
        @program.enroll_num += 1
        @program.save
      else
        # 邀请码表更新
        @invitate = Invitate.find_by_invitate_cd params[:invitate_cd]
        @exist_invitate = Invitate.find_by_user_id_and_program_id current_user.id, params[:id]
        
        if @exist_invitate.nil?
          if @invitate.invitate_flg == Invitate::STATE[:normal]
            @invitate.user_id = current_user.id
            @invitate.invitate_flg = Invitate::STATE[:used]
            @invitate.save
          else
            format.json { render json: { :failed => '无效的邀请码' }, status: :ok }
          end
        else
          @invitate.user_id = current_user.id
          @invitate.invitate_flg = Invitate::STATE[:used]
          @invitate.save
        end
      end


      if @appointment.nil?
        @appointment = current_user.appointments.build(:user_id => current_user.id, 
        :program_id => params[:id],
        :state => Appointment::STATE[:normal])
        if @appointment.save
          format.json { render json: @appointment, status: :created, notice: '预约成功' }
        else
          format.json { render json: { :result => '预约失败' }, status: :unprocessable_entity }
        end
      else
        @appointment.state = Appointment::STATE[:normal]
        if @appointment.save
          format.json { render json: { :result => '预约成功' }, status: :ok }
        else
          format.json { render json: { :result => '预约失败' }, status: :ok }
        end
      end
    end
  end

  def unappoint
    @appointment = Appointment.find_by_user_id_and_program_id current_user.id, params[:id]
    @appointment.state = Appointment::STATE[:cancelled]

    @invitate = Invitate.find_by_user_id_and_program_id current_user.id, params[:id]

    if @invitate.nil?
      # 预约人数－1
      @program = Program.find(params[:id])
      @program.enroll_num -= 1
      @program.save
    end

    respond_to do |format|
      if @appointment.save
        format.json { render json: { :result => '取消成功' }, status: :ok }
      else
        format.json { render json: { :result => '取消失败' }, status: :ok }
      end
      
    end
  end

  def search
    @programs = Program.where('title LIKE ?', "%#{params[:q]}%").page(params[:page])
    respond_to do |format|
      format.js { render :program_search }
    end
  end

  # GET /programs/new
  def new
   @program = Program.new
    #  @program = current_user.programs.build
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(program_params)
    respond_to do |format|


      if @program.save
        format.html { render :new }
        format.json { render json: {'id'=>@program.id}}
      else
        format.html { render :new }
        format.json { render json: @program.errors, :status => 400 }
      end
    end
  end

  def quiz
    @question = Question.new
    @question.asker_id = current_user.id
    @question.program_id = params[:program_id]
    @question.title = params[:title]
    @question.content = params[:content]
    @question.state = Question::STATE[:normal]

    respond_to do |format|
      if @question.save

        @latest_qustions = Question.where(:program_id => params[:program_id]).order('updated_at desc').limit 5
        
        data = Array.new
        @latest_qustions.each do |l_question|
          q_data = {:username => current_user.username,
                    :title => l_question.title,
                    :updated_at => l_question.updated_at.strftime("%Y-%m-%d %H:%M:%S"),
                    :id => l_question.id.to_s,
                    :replies => l_question.replies.length}
          data.push(q_data);
        end
        format.json { render json: {'save'=>'sucess', 'data'=>data}}
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def comment
    @comment = current_user.comments.find_by_program_id params[:program_id]
    if @comment.nil?
      @comment = Comment.new
      @comment.user_id = current_user.id
      @comment.program_id = params[:program_id]
    end
    @comment.rank = params[:rank]
    @comment.content = params[:content]
    @comment.state = Comment::STATE[:normal]

    respond_to do |format|
      if @comment.save

        @latest_comments = current_user.comments.where(:program_id=>params[:program_id]).order('updated_at desc').limit 5
        
        data = Array.new
        @latest_comments.each do |l_comment|
          q_data = {:username => current_user.username,
                    :content => l_comment.content,
                    :updated_at => l_comment.updated_at.strftime("%Y-%m-%d %H:%M:%S"),
                    :rank => l_comment.rank,
                    :id => l_comment.id}
          data.push(q_data);
        end
        format.json { render json: {'save'=>'sucess', 'data'=>data}}
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_comment
    @comment = current_user.comments.find_by_program_id(params[:program_id])
    respond_to do |format|
      if @comment.nil?
        format.json { render json: {'rank'=>'', 'content'=>''}}
      else
        format.json { render json: {'rank'=>@comment.rank, 'content'=>@comment.content}}
      end
    end
  end

  def control
    @current_page = $global_redis.get("current_page") || 0
  end

  def save_time_line
    time_line = $global_redis.smembers("live_program_#{params[:program_id]}")

    array = Array.new
    if !time_line.nil?
      array.push(0)
      for i in 0..time_line.length-2
        array.push(time_line[i + 1].to_i - time_line[i].to_i)
      end
      @courseware = Courseware.create(
          :uploader_id => current_admin.id,
          :program_id => params[:program_id],
          :name => Time.now.strftime("%Y%m%d"),
          :type_of_courseware => Courseware::TYPE[:video],
          :remote_or_local => Courseware::REMOTE_OR_LOCAL[:local],
          :time_line => array)
      respond_to do |format|
        format.json { render json: {'time_line'=>time_line}}
      end
      $global_redis.del("live_program_#{params[:program_id]}")
    end
  end

  def save_interactive
    @usersVsInteractive = UsersVsInteractive.create(
      :user_id => current_user.id,
      :interactive_id => params[:interactive_id],
      :options => params[:selections])
    respond_to do |format|
      format.json { render json: {'data'=>'sucess'}}
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:title, :preview, :intro, :online_date, :offline_date, :live_or_replay, :categories, :speakers)
    end
end
