class User::BookshelfController < ApplicationController
  before_action :set_bookshelf, only: [:update, :destroy]

  def create
    comics = Comics.find(bookshelf_params[:comics_id])
    @user_bookshelf = current_user.bookshelf.find_by(comics: comics)

    if @user_bookshelf
      flash[:error] = "既に本棚にあります。"
    else
      @bookshelf = current_user.bookshelf.new(bookshelf_params)
      if @bookshelf.save
        flash[:success] = "本棚に追加しました。"
      else
        flash[:error] = "本棚に追加できませんでした。"
      end
    end
    redirect_to bookshelf_path
  end

  def index
    @bookshelf = current_user.bookshelf
  end

  def update
    if @bookshelf.update(bookshelf_params)
      flash[:success] = "本棚を更新しました。"
    else
      flash[:error] = "本棚の更新に失敗しました。"
    end
    redirect_to bookshelf_path
  end

  def destroy
    @bookshelf.destroy
    flash[:success] = "漫画を本棚から削除しました。"
    redirect_to bookshelf_path
  end

  private

  def set_bookshelf
    @bookshelf = current_user.bookshelf.find(params[:id])
  end

  def bookshelf_params
    params.require(:bookshelf).permit(:comics_id, :book_id)
  end
end