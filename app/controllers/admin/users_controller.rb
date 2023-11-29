class Admin::UsersController < ApplicationController
  def index
    @users = User.all # 有効な顧客と退会した顧客をすべて取得
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update #顧客の登録情報更新
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '登録情報を更新しました'
      redirect_to admin_users_path(@user) # 更新成功時にマイページにリダイレクト
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :is_active)
  end
end
