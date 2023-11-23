class User::TagsController < ApplicationController

  def new
    @tags = current_user.tags
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user_id = current_user.id
    if @tag.save
      redirect_to tags_path, notice: '新しいタグが作成されました'
    else
      @user = current_user
      @tags =Tag.all
      render :new
    end
  end
  
  def index
    @tags = current_user.tags
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

end
