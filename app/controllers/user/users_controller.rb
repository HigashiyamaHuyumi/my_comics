class User::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:my_page, :show, :infomation, :update, :confirm, :withdrawal]

  def my_page #顧客のマイページ
    @user = current_user
    order_by = params[:order] || 'initial' # パラメータがない場合は頭文字順にデフォルト
    @comic = @user.comic.order(order_by)
    @total_hardcover_volumes = @user.total_hardcover_volumes
    @total_titles_count = @user.comic.total_titles_count

    # 検索クエリに基づいてコミックを絞り込む
    @search_query = params[:search]
    if @search_query.present?
      @comics = @user.comics.search(@search_query)
      unless @comics.present?
        flash[:notice] = '検索に一致するデータがありませんでした'
      end
    end
  end

  def show
    @user = current_user
  end

  def infomation #顧客の登録情報編集画面
    @user = current_user
  end

  def update #顧客の登録情報更新
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = '登録情報を更新しました'
      redirect_to user_path(@user)
    else
      render 'infomation'
    end
  end

  def confirm #退会確認画面
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def withdrawal  #退会画面
    @user = User.find(params[:id])
    @user.update(is_active: false)
    sign_out @user
    redirect_to root_path, notice: "アカウントが削除されました。"
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :is_active, :password, :password_confirmation)
  end

  def is_matching_login_user
    @user = current_user
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
