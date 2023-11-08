# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password]) && user.is_active
      sign_in user
      redirect_to root_path
    else
      flash[:alert] = "ログインできません。アカウントが無効になっているか、パスワードが正しくありません。"
      render new_user_registration_path
    end
  end

  protected

  def user_state
    @user = User.find_by(email: params[:user][:email]) # 入力されたemailからアカウントを1件取得

    if !@user # アカウントが見つからない場合
      flash[:alert] = "アカウントが見つかりませんでした。"
      redirect_to new_user_registration_path
    elsif !@user.is_active? # 退会している場合
      flash[:alert] = "退会済みのアカウントです。"
      redirect_to new_user_registration_path
    end
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
