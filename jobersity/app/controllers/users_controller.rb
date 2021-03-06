class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:last_name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
     @current_user = User.find_by(id: params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save

        UserMailer.welcome_email(@user).deliver_now

        format.html { redirect_to @user,
          notice: "User #{@user.last_name}, #{@user.first_name} was successfully created." }
        format.json { render action: 'show',
          status: :created, location: @user }
          redirect_to inicio_url, notice: "Inicio sesion"
      else
        format.html {redirect_to inicio_url, notice: "Inicio sesion"  } #render action: 'new'
        format.json { render json: @user.errors,
          status: :unprocessable_entity }

      end
    end
  end

  def login

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user,
          notice: "User #{@user.last_name}, #{@user.first_name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors,
          status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
      flash[:notice] = "User #{@user.last_name}, #{@user.first_name} deleted"
    rescue StandardError => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
