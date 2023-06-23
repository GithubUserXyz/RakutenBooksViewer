# Rakuten Books Viewer

## 概要

楽天booksさんのapiを使って、本の情報を閲覧できるアプリ。

## 使い方

### 準備

概要にある通り、楽天booksさんのapiを利用する。そのためには、楽天さんの会員登録をして、そのあと、application idというものを取得する必要がある。取得できたら、それをこのプログラムのlib/application_id_org.dartというファイルの中に記述してある、applicationId=""というところがあるので、そこに取得したapplication idを転記し、ファイル名から_orgを消して、application_id.dartというファイル名にする。

### 実行

次のコマンドより実行。

```sh
flutter run
```