class User::BookshelvesController < ApplicationController

  def index
    @bookshelves = current_user.bookshelves.page(params[:page]).per(10)
  end
  
  def create
    isbn = params[:isbn]
    book = Book.find_or_create_by(isbn: isbn) do |new_book|
      new_book.attributes = read(params[:book])
    end

    current_user.bookshelves.find_or_create_by(book: book)
    redirect_to books_search_path, notice: '本がブックマークに追加されました。'
  end
  
  def show
    @bookshelf = current_user.bookshelves.find(params[:id])
  end

  def edit
    @bookshelf = current_user.bookshelves.find(params[:id])
  end

  def update
    @bookshelf = current_user.bookshelves.find(params[:id])
    if @bookshelf.update(bookshelf_params)
      redirect_to bookshelves_path, notice: '本を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @bookshelf = current_user.bookshelves.find(params[:id])
    @bookshelf.destroy
    flash[:success] = "選んだ本を削除しました。"
    redirect_to  bookshelves_path
  end

  private
  
  def bookshelf_params
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

end