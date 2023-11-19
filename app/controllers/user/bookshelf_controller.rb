class User::BookshelfController < ApplicationController
  before_action :set_bookshelf, only: [:update, :destroy]

  def index
    book = Book.find(bookshelf_params[:book_id])
    @user_bookshelf = current_user.bookshelf.find_by(book: book)

    if @user_bookshelf
      flash[:error] = "既に本棚にあります。"
    else
      @bookshelf = current_user.bookshelf.new(book: book)

      if @bookshelf.save
        flash[:success] = "本棚に追加しました。"
      else
        flash[:error] = "本棚に追加できませんでした。"
        Rails.logger.debug(@bookshelf.errors.full_messages) # エラーがあればログに出力
      end
    end
    redirect_to my_page_path
  end

  def index
    @bookshelf = current_user.bookshelf
  end

  def show
    @bookshelf = current_user.bookshelf.find(params[:id])
  end

  def update
    if @bookshelf.update(bookshelf_params)
      flash[:success] = "本棚を更新しました。"
    else
      flash[:error] = "本棚の更新に失敗しました。"
    end
    redirect_to my_page_path
  end

  def destroy
    @bookshelf.destroy
    flash[:success] = "漫画を本棚から削除しました。"
    redirect_to my_page_path
  end

  private

  def set_bookshelf
    @bookshelf = current_user.bookshelf.find(params[:id])
  end

  def bookshelf_params
    params.permit(:book_id, :isbn, :user_id)
  end

end