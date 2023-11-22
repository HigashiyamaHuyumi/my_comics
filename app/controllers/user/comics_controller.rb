class User::ComicsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @comic = Comic.new
    @tags = Tag.all
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id

    if @comic.save
      # 保存成功時にも@tagsをセット
      @tags = Tag.all
      redirect_to my_page_path, notice: '漫画が作成されました'
    else
      render :new
    end
  end

  def index # データの一覧を表示する
    @comics = Comic.all
    @user = current_user
  end

  def show #データの内容（詳細）を表示する
    @comic = Comic.find(params[:id])
    @tags = @comic.tags.pluck(:name).join(',')
  end

  def edit #データを更新するためのフォームを表示す
    @comic = Comic.find(params[:id])
    @tags = Tag.all
  end

  def update
    @comic = Comic.find(params[:id])

    if @comic.update(comic_params)
      # 既存のタグが選択されている場合
      if params[:comic][:tag_ids].present?
        @comic.tag_ids = params[:comic][:tag_ids]
      end

      # 新しいタグが入力されている場合
      if params[:comic][:new_tag].present?
        @comic.tags << Tag.find_or_create_by(name: params[:comic][:new_tag])
      end

      flash[:notice] = '漫画の情報を更新しました'
      redirect_to comic_path(@comic.id)
    else
      render :edit
    end
  end

  def destroy #データを削除する
    @comic = Comic.find(params[:id])
    @comic.destroy  # データ（レコード）を削除
    flash[:notice] ='選んだ漫画を本棚から削除しました'
    redirect_to my_page_path # 投稿一覧画面へリダイレクト
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :author, :publisher, :remarks, :tag_ids, :new_tag)
  end

  def is_matching_login_user
    comic = Comic.find(params[:id])
    unless comic.user_id == current_user.id
      redirect_to comics_path
    end
  end
end
