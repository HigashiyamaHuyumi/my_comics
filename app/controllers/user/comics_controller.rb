class User::ComicsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @comics = Comics.new
  end

  def create #データを追加（保存）する
    @comics = Comics.new(comic_params)
    if @comics.save
      flash[:notice] ='漫画を新しく投稿しました'
      redirect_to comics_path
    else
      @comic = Comics.all
      render :index
    end
  end

  def index # データの一覧を表示する
    @comic = Comics.all
  end


  def show #データの内容（詳細）を表示する
    @comics = Comics.find(params[:id])
  end

  def edit #データを更新するためのフォームを表示す
    @comics = Comics.find(params[:id])
  end

  def update #データを更新する
    @comics = Comics.find(params[:id])
    if @comics.update(comic_params)
     flash[:notice] ='漫画の情報を更新しました'
     redirect_to comics_path(@comics.id)
    else
     render :edit
    end
  end

  def destroy #データを削除する
    @comics = Comics.find(params[:id])
    @comics.destroy  # データ（レコード）を削除
    flash[:notice] ='選んだ漫画を本棚から削除しました'
    redirect_to comics_path # 投稿一覧画面へリダイレクト
  end

  private

  def comic_params
    params.require(:comics).permit(:title, :author, :publisher, :user_id)
  end

  def is_matching_login_user
    comics = Comics.find(params[:id])
    unless comics.user_id == current_user.id
      redirect_to comics_path
    end
  end

end
