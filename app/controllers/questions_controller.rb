class QuestionsController < ApplicationController
  before_action :require_user_login, :only => [:create]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new_reply
    @reply = Reply.new
    @reply.replier_id = current_user.id
    @reply.question_id = params[:question_id]
    @reply.content = params[:content]
    @reply.state = Question::STATE[:normal]

    respond_to do |format|

      if @reply.save
        format.html { render :new }
        format.json { render json: {'id'=>@reply.id}}
      else
        format.html { render :new }
        format.json { render json: @reply.errors, :status => 400 }
      end
    end
  end

  def best_reply
  	@reply = Reply.find(params[:reply_id])
  	@reply.best = true
    respond_to do |format|
      if @reply.save
        format.json { render json: {'id'=>@reply.id}}
      else
        format.json { render json: @reply.errors, :status => 400 }
      end
    end
  end
end
