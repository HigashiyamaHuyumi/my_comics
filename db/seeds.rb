# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@mail', # 任意のメールアドレス
  password: '000000' # 任意のパスワード
)

tags = %w(女性漫画 少女漫画 青年漫画 少年漫画 TL漫画 BL漫画 大人漫画 恋愛 サスペンス・ミステリー
          青春 学園 日常 異世界 人外 ホラー ギャグ・コメディー グルメ スポーツ SF・ファンタジー)

tags.each do |tag_name|
  admin_user.tags.create(name: tag_name)
end