# Rakuten Books Viewer

## 概要

楽天booksさんのapiを使って、本の情報を閲覧できるアプリ。

## 使い方

### 動作確認環境

- プログラムの作成環境はFedora 38にて行っている。
- Flutter SDKのバージョンは3.10.5

### 準備

概要にある通り、楽天booksさんのapiを利用する。そのためには、楽天さんの会員登録をして、そのあと、application idというものを取得する必要がある。取得できたら、それをこのプログラムのlib/application_id_org.dartというファイルの中に記述してある、applicationId=""というところがあるので、そこに取得したapplication idを転記し、ファイル名から_orgを消して、application_id.dartというファイル名にする。

### 実行

次のコマンドより実行。

```sh
flutter run
```

## その他

### 利用API

#### 楽天ブックス書籍検索API

https://webservice.rakuten.co.jp/documentation/books-book-search

### プロジェクト作成

このプロジェクト作成には次のコマンドを使用した。

```sh
flutter create --org com.zpiyo rakuten_books_viewer
```

orgの指定により、後からパッケージ名を指定する必要はない。