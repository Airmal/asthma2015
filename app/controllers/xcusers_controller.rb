class XcusersController < ApplicationController
   before_action :set_xcuser, only: [:show, :edit, :update, :destroy]

  # GET /xcusers
  # GET /xcusers.json
  def index
    @xcusers = Xcuser.all
  end

  # GET /xcusers/1
  # GET /xcusers/1.json
  def show
    # 登陆成功
    @xcuser = User.find(params[:id])
  end

  def live
    @xcuser = User.find_by_phone(params[:xcuser][:phone])
  end

  # GET
  def login
  end

  # POST
  def login_commit
    name = params[:xcuser][:name]
    mobile = params[:xcuser][:phone]
    @xcuser = Xcuser.find_by phone: params[:xcuser][:phone]
    if @xcuser.nil? || @xcuser.name != name
      render :login
    else
      render :live
    end

  end

  # GET /xcusers/new
  def new
    @xcuser = Xcuser.new
  end

  # GET /xcusers/1/edit
  def edit
  end

  # POST /xcusers
  # POST /xcusers.json
  def create
    @xcuser = Xcuser.new(xcuser_params)

    respond_to do |format|
      if Xcuser.all.size >= 300
          format.html { render :new }
          format.json { render json: @xcuser.errors, status: :unprocessable_entity }
      else
          if @xcuser.save
            format.html { redirect_to @xcuser, notice: 'Xcuser was successfully created.' }
            format.json { render :show, status: :created, location: @xcuser }
          else
            format.html { render :new }
            format.json { render json: @xcuser.errors, status: :unprocessable_entity }
          end
      end
    end
  end
  # PATCH/PUT /xcusers/1
  # PATCH/PUT /xcusers/1.json
  def update
    respond_to do |format|
      if @xcuser.update(xcuser_params)
        format.html { redirect_to @xcuser, notice: 'Xcuser was successfully updated.' }
        format.json { render :show, status: :ok, location: @xcuser }
      else
        format.html { render :edit }
        format.json { render json: @xcuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xcusers/1
  # DELETE /xcusers/1.json
  def destroy
    @xcuser.destroy
    respond_to do |format|
      format.html { redirect_to xcusers_url, notice: 'Xcuser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xcuser
      @xcuser = Xcuser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def xcuser_params
      params.require(:xcuser).permit(:name, :phone, :email, :company, :office, :address)
    end
end
