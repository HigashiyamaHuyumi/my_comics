class User::BookshelfController < ApplicationController
  before_action :set_bookshelf, only: [:update, :destroy]

  def index
    @bookshelves = current_user.bookshelves
  end
  
  def create
    @book = Book.find_or_create_by(isbn: params[:isbn]) do |new_book|
      new_book.attributes = read(params[:book])
    end

    current_user.bookshelves.find_or_create_by(book: @book)

    redirect_to user_bookshelves_path, notice: '本が本棚に追加されました。'
  end

  def show
    @bookshelf = current_user.bookshelves.find(params[:id])
  end

  def edit
    @bookshelf = current_user.bookshelfves.find(params[:id])
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
    @bookshelf = current_user.bookshelves.find(params[:id])
    @bookshelf.destroy
    flash[:success] = "本を本棚から削除しました。"
    redirect_to my_page_path
  end

  private
  
  def bookshelf_params
    # ストロングパラメータを正しく設定
    params.require(:bookshelf).permit(:custom_attribute)
  end
  
  def read(book_params)
    # 必要なデータを抽出してハッシュとして返す
    {
      title: book_params["title"],
      author: book_params["author"],
      publisherName: book_params["publisherName"],
      url: book_params["itemUrl"],
      isbn: book_params["isbn"],
      image_url: book_params["mediumImageUrl"]&.gsub('?_ex=120x120', ''),
      salesDate: book_params["salesDate"],
    }
  end

end