class User::BooksController < ApplicationController

  def search
    @books = []
    @title = params[:title]

    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        applicationId: "1044821469818202176"
      })

      results.each do |result|
        book = Book.find_or_create_by(isbn: result["isbn"]) do |new_book|
          new_book.attributes = read(result)
        end

        # ユーザーのbookshelfに追加
        current_user.bookshelves.find_or_create_by(book: book)
        @books << book
      end
    end
  end

  def show #データの内容（詳細）を表示する
    @book = Book.find_by(isbn: params[:id])
  end
  
  def bookshelf
    book_ids = params[:book_ids]
  
    if book_ids.blank?
      flash[:error] = "本を選択してください。"
    else
      book_ids.each do |book_id|
        book = Book.find(book_id)
        
        # ユーザが既に本を本棚に追加しているか確認
        if current_user.bookshelves.find_by(book: book)
          flash[:error] = "#{book.title} は既に本棚にあります。"
        else
          # ユーザの本棚に本を追加
          current_user.bookshelves.create(book: book)
          flash[:success] ||= []
          flash[:success] << "#{book.title} を本棚に追加しました。"
        end
      end
    end
  
    redirect_to my_page_path
  end


  private

  #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    title = result["title"]
    author = result["author"]
    publisherName = result["publisherName"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    salesDate = result["salesDate"]
    {
      title: title,
      author: author,
      publisherName: publisherName,
      url: url,
      isbn: isbn,
      image_url: image_url,
      salesDate: salesDate,
    }
  end

end
