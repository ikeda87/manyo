class Admin::UsersController < ApplicationController
  before_action :set_admin_user, only:[:show, :edit, :destroy, :update]
  before_action :ensure_admin_user, only:[:index, :new, :create, :show, :edit, :update, :destroy]
  def index
    @users = User.select(:id, :name, :email, :admin)
  end
  def new
    @users = User.new
  end
  def create
    @users = User.new(user_params)
    if @users.save
      redirect_to admin_users_path,notice: "ユーザーを新しく登録しました。"
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @users.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー情報を変更しました。"
    else
      render :edit
    end
  end
  def destroy
    if @users.admin == true
      if User.where(admin: true).count > 1
        @users.destroy
        redirect_to admin_users_path, notice: "ユーザーを削除しました。"
      else
        redirect_to admin_users_path, notice: "最低1ユーザーは管理者権限を持つ必要があります。"
      end
    else
      @users.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました。"
    end
  end
  private
  def user_params
    params.require(:user).permit(:name,:email,:password,
                                 :password_confirmation,:admin)
  end
  def set_admin_user
    @users = User.find(params[:id])
  end
end
