# ButterSand

[![Build Status](https://travis-ci.org/shunsugai/butter_sand.png?branch=master)](https://travis-ci.org/shunsugai/butter_sand)

六花亭さんの催事情報ページの内容を取得するためのRubyラッパーです

## インストール方法

Gemfileに次の一行を追加してください:

    gem 'butter_sand'

次に以下のコマンドを実行してください:

    $ bundle

もしくはbundlerを使わずに以下のコマンドでインストールしてもOKです:

    $ gem install butter_sand

## 使いかた

### 催事情報を取得する
```ruby
require 'butter_sand'

# 全件取得
ButterSand.all.each do |event|
  puts event.shop        #=> 店名
  puts event.prefecture  #=> 県
  puts event.phone       #=> 電話番号
  puts event.starts      #=> 開始日
  puts event.ends        #=> 終了日
end

# 今日から始まる催事情報
ButterSand.starts_today

# 今日で終わる催事情報
ButterSand.ends_today

# 県名で調べる
ButterSand.find_by_prefecture('東京')
```

### TODO
JSON返すやつ作る

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
