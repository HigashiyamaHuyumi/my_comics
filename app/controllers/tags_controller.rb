class TagsController < ApplicationController
  before_action :set_tags, only: [:new, :edit]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: '新しいタグが作成されました'
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path, notice: 'タグが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] ='選んだタグを削除しました'
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
    @tags = Tag.all
  end
end
