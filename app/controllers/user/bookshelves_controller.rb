class User::BookshelvesController < ApplicationController
  before_action :set_bookshelves, only: [:update, :destroy]

  def index
    @bookshelves = current_user.bookshelves
  end
  
  def create
    @book = Book.find_or_create_by(isbn: params[:isbn]) do |new_book|
      new_book.attributes = read(params[:book])
    end
    current_user.bookshelves.find_or_create_by(book: @book)
    redirect_to books_search_path, notice: '本がブックマークに追加されました。'
  end

  def show
    @bookshelf = current_user.bookshelves.find(params[:id])
  end

  def edit
    @bookshelf = current_user.bookshelves.find(params[:id])
    Rails.logger.debug(@bookshelf.inspect)
  end

  def update
    @bookshelf = current_user.bookshelves.find(params[:id])

    if @bookshelf.update(bookshelf_params)
      redirect_to bookshelves_path, notice: 'Bookshelf updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @bookshelves = current_user.bookshelves.find(params[:id])
    @bookshelves.destroy
    flash[:success] = "選んだ本を削除しました。"
    redirect_to  bookshelves_path
  end

  private
  
  def bookshelf_params
    # ストロングパラメータを正しく設定
    params.require(:bookshelf).permit(:title, :author, :publisherName)
  end
  
  def read(book_params)
    # 必要なデータを抽出してハッシュとして返す
    {
      title: book_params["title"],
      author: book_params["author"],
      publisherName: book_params["publisherName"],
      isbn: book_params["isbn"],
      image_url: book_params["mediumImageUrl"]&.gsub('?_ex=120x120', ''),
      salesDate: book_params["salesDate"],
    }
  end
  
  def set_bookshelves
    @bookshelves = current_user.bookshelves.find(params[:id])
  end

end