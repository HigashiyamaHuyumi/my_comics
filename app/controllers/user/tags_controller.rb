class User::TagsController < ApplicationController
  
  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      redirect_to tags_path, notice: '新しいタグが作成されました'
    else
      puts @tag.errors.full_messages
      @tags = current_user.tags 
      render :index
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
