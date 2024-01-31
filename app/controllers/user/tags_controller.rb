class User::TagsController < ApplicationController
  def create
    @tag = current_user.tags.build(tag_params)
    if @tag.save
      redirect_to tags_path, notice: '新しいタグが作成されました'
    else
      flash[:notice] ='タグ名が空白か、既に存在します'
      @tags = current_user.tags
      render :index
    end
  end
  
  def index
    allowed_orders = ['name', 'comic_tags_count'] # 許可された順序のリスト
    order_by = params[:order].in?(allowed_orders) ? params[:order] : 'name' # パラメータが不正な場合はデフォルトで 'name'
    
    case order_by
    when 'name'
      @tags = current_user.tags.order(:name)
    when 'comic_tags_count'
      @tags = current_user.tags.left_joins(:comic_tags).group(:id).order('COUNT(comic_tags.tag_id) DESC')
    end
  end
  
  def comic
    # タグが存在するか確認
    @tag = Tag.find_by(id: params[:id])
  
    if @tag.nil?
      flash[:alert] = "指定されたタグは存在しません。"
      redirect_to tags_path
      return
    end
  
    # タグに紐づく漫画を取得
    @comics = @tag.comics
  end

  def destroy
    # タグを削除できるのは、作成者のみ
    if @tag.user == current_user
      @tag.destroy
      redirect_to tags_path, notice: 'タグが削除されました。'
    else
      flash[:alert] = '他のユーザーのタグを削除することはできません。'
      redirect_to tags_path
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
