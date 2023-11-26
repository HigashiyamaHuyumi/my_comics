class User::ComicsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id

    if @comic.save
      @tags = Tag.all
      redirect_to my_page_path, notice: '漫画が作成されました'
    else
      render :new
    end
  end

  def index # データの一覧を表示する
    @comics = current_user.comics
  end

  def show #データの内容（詳細）を表示する
    @comic = Comic.find(params[:id])
    @tags = @comic.tags.pluck(:name).join(',')
  end

  def edit #データを更新するためのフォームを表示す
    @comic = Comic.find(params[:id])
    @tags = Tag.where(user_id: current_user.id)
  end

  def update
    @comic = Comic.find(params[:id])
  
    begin
      if @comic.update(comic_params)
        @tags = Tag.all
  
        # 既存のタグが選択されている場合
        if params[:comic][:tag_ids].present?
          @comic.tag_ids = params[:comic][:tag_ids]
        end
  
        # 新しいタグが入力されている場合
        if params[:comic][:new_tag].present?
          new_tags = params[:comic][:new_tag].split(',').map(&:strip)
          new_tags.each do |new_tag_name|
            # 既に存在するタグと同じ名前の場合は重複を避ける
            existing_tag = Tag.find_by(name: new_tag_name)
            unless existing_tag
              new_tag = Tag.find_or_create_by(name: new_tag_name)
              new_tag.user = current_user
              new_tag.save
              @comic.tags << new_tag
            end
          end
        end
  
        flash[:notice] = '漫画の情報を更新しました'
        redirect_to comic_path(@comic.id)
      else
        render :edit
      end
    rescue ActiveRecord::RecordInvalid
      flash[:alert] = 'エラーが発生しました。重複するタグが存在する可能性があります。'
      redirect_to comic_path(@comic.id)
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
    params.require(:comic).permit(:title, :author, :publisherName, :story, :purchase_place, :comics_size, :remarks, new_tag: [] , tag_names: [])
  end

  def is_matching_login_user
    comic = Comic.find(params[:id])
    unless comic.user_id == current_user.id
      flash[:alert] = '他のユーザーの漫画を編集する権限がありません。'
      redirect_to comics_path
    end
  end
end