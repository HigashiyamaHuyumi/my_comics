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

Tag.create([
  { name: '女性漫画' },
  { name: '少女漫画' },
  { name: '青年漫画' },
  { name: '少年漫画' },
  { name: 'TL漫画' },
  { name: 'BL漫画' },
  { name: '大人漫画' }
])