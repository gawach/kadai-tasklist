class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:sucess] = 'ユーザーの登録に成功しました'
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました'
      render :new
    end
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
end