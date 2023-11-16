class User::ComicController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @comic = Comic.new
  end

  def create #データを追加（保存）する
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id # ログインしているユーザーのIDを設定
    if @comic.save
      flash[:notice] ='You have created book successfully.'
      redirect_to comic_path(@comic)
    else
      @user = current_user
      @comics = Comics.all
      render :index
    end
  end

  def index # データの一覧を表示する
    @comic = Comic.new
    @comics = Comic.all
    @user = current_user
  end

  def show #データの内容（詳細）を表示する
    @comic = Comic.find(params[:id])
  end

  def edit #データを更新するためのフォームを表示す
    @comic = Comic.find(params[:id])
  end

  def update #データを更新する
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
     flash[:notice] ='漫画の情報を更新しました'
     redirect_to comic_path(@comic.id)
    else
     render :edit
    end
  end

  def destroy #データを削除する
    @comic = Comic.find(params[:title])
    @comic.destroy  # データ（レコード）を削除
    flash[:notice] ='選んだ漫画を本棚から削除しました'
    redirect_to comics_path # 投稿一覧画面へリダイレクト
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :author, :publisher, :user_id)
  end

  def is_matching_login_user
    comic = Comic.find(params[:id])
    unless comic.user_id == current_user.id
      redirect_to comics_path
    end
  end

end
