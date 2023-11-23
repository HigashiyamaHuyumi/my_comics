class User::BookshelfController < ApplicationController
  before_action :set_bookshelf, only: [:update, :destroy]

  def create
    book = Book.find(bookshelf_params[:book_id])
    @user_bookshelf = current_user.bookshelf.find_by(book: book)

    if @user_bookshelf
      flash[:error] = "既に本棚にあります。"
      redirect_to my_page_path
      return
    end
    
    @bookshelf = current_user.bookshelf.new(book: book)
    
    if @bookshelf.save
      flash[:success] = "本棚に追加しました。"
    else
      flash[:error] = "本棚に追加できませんでした。"
      Rails.logger.error(@bookshelf.errors.full_messages.join(', ')) # エラーがあればログに出力
    end
    
    redirect_to my_page_path
  end

  def index
    @bookshelf_books = current_user.bookshelf_books
    @bookshelf = Bookshelf.new
  end

  def show
    @bookshelf = current_user.bookshelf.find(params[:id])
  end
  
  def edit
    @bookshelf_book = current_user.bookshelf_books.find(params[:id])
  end

  def update
    @bookshelf_book = current_user.bookshelf_books.find(params[:id])
    if @bookshelf_book.update(bookshelf_params)
      redirect_to my_page_path, notice: '書籍が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @bookshelf.destroy
    flash[:success] = "漫画を本棚から削除しました。"
    redirect_to my_page_path
  end

  private

  def set_bookshelf
    @bookshelf = Bookshelf.find(params[:id])
  end

  def bookshelf_params
    params.require(:bookshelf).permit(:your_attributes)
  end

end