class User::BookshelfController < ApplicationController
  before_action :set_bookshelf, only: [:update, :destroy]

  def create
    book = Book.find_by(isbn: params[:isbn])
    user_bookshelf_book = current_user.bookshelves.find_by(book: book)

    if user_bookshelf_book
      flash[:error] = "既に本棚にあります。"
    else
      bookshelf_book = current_user.bookshelves.create(book: book)
      if bookshelf_book.valid?
        flash[:success] = "本棚に追加しました。"
      else
        flash[:error] = "本棚に追加できませんでした。"
        Rails.logger.error(bookshelf_book.errors.full_messages.join(', '))
      end
    end

    redirect_to my_page_path
  end

  def index
    @bookshelf_books = current_user.bookshelf_books
  end

  def show
    @bookshelf_book = current_user.bookshelf_books.find(params[:id])
  end

  def edit
    @bookshelf_book = current_user.bookshelf_books.find(params[:id])
  end

  def update
    # 本棚の本を更新
    if @bookshelf.update(bookshelf_params)
      flash[:success] = "本の情報が更新されました。"
      redirect_to bookshelf_path(@bookshelf)
    else
      render :edit
    end
  end

  def destroy
    # 本棚から本を削除
    @bookshelf.destroy
    flash[:success] = "本を本棚から削除しました。"
    redirect_to my_page_path
  end

  private

  def set_bookshelf
    # 特定の本棚を取得
    @bookshelf = Bookshelf.find_by(id: params[:id])
  
    unless @bookshelf
      flash[:error] = "指定された本棚が見つかりませんでした。"
      redirect_to my_page_path
    end
  end

  def bookshelf_params
    # ストロングパラメータを正しく設定
    params.require(:bookshelf_book).permit(:your_attributes, :another_attribute)
  end

end