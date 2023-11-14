class BooksController < ApplicationController

  def search
    @books = []
    @title = params[:title]
    if @title.present?
      #この部分でresultsに楽天APIから取得したデータ（jsonデータ）を格納します。
      #今回は書籍のタイトルを検索して、一致するデータを格納するように設定しています。
      results = RakutenWebService::Books::Book.search({
        title: @title,
        applicationId: "1044821469818202176"
      })

      results.each do |result|
        book = Book.new(read(result))  #read(result)については、privateメソッドとして、設定
        @books << book #「@books」にAPIからの取得したJSONデータを格納
      end
    end

    @books.each do |book|  #「@books」内の各データをそれぞれ保存していきます。
      unless Book.all.include?(book)  #すでに保存済の本は除外するためにunlessの構文を記載しています。
        book.save
      end
    end
  end

  private

  #「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    salesDate = result["salesDate"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      salesDate: salesDate,
    }
  end

end