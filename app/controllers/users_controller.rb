class UsersController < ApplicationController
  before_action :set_user,only:[:show]
  before_action :ensure_current_user, only:[:show]
  
  def new
    if logged_in?
      flash[:danger] = '権限がありません。'
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "アカウント作成後、ログインしました。"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
