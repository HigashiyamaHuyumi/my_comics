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

        # 選択された本のIDがあれば本棚に追加
        if params[:selected_book_id] == book.id.to_s
          current_user.bookshelves.find_or_create_by(book: book)
        end

        @books << book
      end
    end
  end

  private

  #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    {
      title: result["title"],
      author: result["author"],
      publisherName: result["publisherName"],
      url: result["itemUrl"],
      isbn: result["isbn"],
      image_url: result["mediumImageUrl"].gsub('?_ex=120x120', ''),
      salesDate: result["salesDate"],
    }
  end

end