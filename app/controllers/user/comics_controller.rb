class User::ComicsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    @comic.user_id = current_user.id

    if @comic.save
      @tags = Tag.all
      @volumes = Volume.all
      redirect_to comic_path(@comic), notice: '漫画が作成されました'
    else
      render :new
    end
  end

  def show
    @comic = Comic.find(params[:id])

    if @comic.nil?
      flash[:alert] = "指定された漫画は存在しません。"
      redirect_to my_page_path
      return
    end

  end

  def edit #データを更新するためのフォームを表示す
    @comic = Comic.find(params[:id])
    @volumes = Volume.where(user_id: current_user.id)
    @tags = Tag.where(user_id: current_user.id)
  end

  def update
    @comic = Comic.find(params[:id])

    if @comic.update(comic_params)
      @tags = Tag.all
      @volumes = Volume.all

      # 既存のタグが選択されている場合
      @comic.tag_ids = params[:comic][:tag_ids].presence || []

      # 新しいタグが入力されている場合
      if params[:comic][:new_tag].present?
        new_tags = params[:comic][:new_tag].split(',').map(&:strip)
        new_tags.each do |new_tag_name|
          # 既に存在するタグと同じ名前の場合は既存のタグを追加するだけにする
          existing_tag = Tag.find_by(name: new_tag_name, user_id: current_user.id)
          if existing_tag
            @comic.tags << existing_tag
          else
            new_tag = Tag.find_or_create_by(name: new_tag_name, user_id: current_user.id)
            @comic.tags << new_tag
          end
        end
      end

      # 既存の巻が選択されている場合
      @comic.volume_ids = params[:comic][:volume_ids].presence || []

      # 新しい巻が入力されている場合
      if params[:comic][:new_volume].present?
        new_volumes = params[:comic][:new_volume].split(',').map(&:strip)
        new_volumes.each do |new_volume_name|
          # 既に存在する巻数と同じ番号の場合は既存の巻数を追加するだけにする
          existing_volume = Volume.find_by(name: new_volume_name, user_id: current_user.id, comic_id: @comic.id)
          if existing_volume
            @comic.volumes << existing_volume
          else
            new_volume = Volume.create(name: new_volume_name, user_id: current_user.id, comic_id: @comic.id)
            @comic.volumes << new_volume
          end
        end
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
    params.require(:comic).permit(:title, :initial, :author, :publisherName, :situation, :story, :medium, :medium_custom, :comic_size, :remarks, :tags, new_tag: [], new_volume: [], volume_ids: [])
  end

  def is_matching_login_user
    comic = Comic.find(params[:id])
    unless comic.user_id == current_user.id
      flash[:alert] = '他のユーザーの漫画を編集する権限がありません。'
      redirect_to comics_path
    end
  end
end