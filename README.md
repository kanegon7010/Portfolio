# [CNS]
![black_logo](https://user-images.githubusercontent.com/60307311/105665063-7f548a00-5f19-11eb-9b9b-2d251da39101.png)

# アプリ概要
<strong>海外の履歴書（CV）</strong>を参考とした**説得力**のある投稿が可能となるTwitterライクSNSサービスです。
転職活動用のポートフォリオとして開発した個人アプリとなります。

**CV**とは、ラテン語の**Curriculum Vitae**の略語で英語になおすと”**course of life**”つまり”**人生の道筋**”という意味です。



- SNSの基本機能である投稿・リプライ・削除ができる
- CV（スキルや経歴、資格など）を表示・非表示ができる
- コミュニケーションを促す、フォロー・通知・DM機能を実装

# URL
https://cv-networking-service.site

**ゲストユーザーでログイン**できます。

# このアプリを開発した背景

### **情報過多なインターネットにおいて「説得力のある発信」を見極めたい**

**個人の発信が非常に容易**になった現代社会において、TwitterやYoutubeなど様々な媒体で、様々な情報を受け取りやすくなっています。
その一方で、**情報量の多さに求めている情報に辿り着くまでに時間がかかったり**、**誤った情報の発信**を疑いもなくそのまま**鵜呑み**にしてしまうことがあります。


### **個人で発信するSNSで、「キャリアが形成できる」のではないか**

一般的に就職や転職では、履歴書の内容を利用して面接を行っていると思います。**限られた面接時間と履歴書の内容**では、上手く**お互いの考えを伝えることが出来ない**といった可能性があります。
**SNSでは、自身の考えや実績などを発信されている**ため、サービスを通じて上記のギャップを埋められるのではないかと考えました。


上記の２点から**履歴書の情報を軸とした新しいキャリアを形成できるプラットフォーム**を目指したアプリを作成いたしました。


# アプリのポイント

- **完全に独学**で開発
- **webpacker**が標準となった**Rails6**で実装
- **TailwindCSS**でのデザイン
- **Vanilla JavaScript**で実装
- **gem(cocoon)を使用せず、要素を動的に追加する機能を実装**（CV作成機能）
- **画面遷移を必要としない返信機能**（タイムライン、リプライ詳細画面）
- **ボタン押下による検索結果の表示切り替え**（検索結果画面）
- 主要機能を**ajaxで実装**（投稿、フォロー、ダイレクトメッセージ）
- **開発環境でDocker**を採用（gemのソース閲覧ができる構成）
- **RSpec**を使用した、テストコード数が**200件**以上あります

# 今後実装したい機能
* CircleCIの導入
* JavaScriptフレームワークを導入してSPA化をする
* スカウト・エントリー機能（企業と個人を結びつける機能）
* AWSのECSやECRを使った本番環境のコンテナ化


## 使用技術等
### フロントエンド
* TailwindCSS
* JavaScript
### バックエンド
* Ruby 2.6.6
* Rails 6.0.3.4
### 開発環境
* Docker/Docker-compose
* MySQL2
### 本番環境
* AWS（VPC | ALB | EC2 | S3 | Route53 | ACM）
* MySQL2
* Nginx, Unicorn


# AWS構成図
![cns_infra](https://user-images.githubusercontent.com/60307311/105674134-66080980-5f2a-11eb-95b8-6451994b7c4a.jpg)

# 機能一覧
- ユーザー機能
- CV機能
- 投稿機能
- リプライ機能
- フォロー機能
- 検索機能
- ダイレクトメッセージ機能
- 通知機能
- テスト機能

# 機能詳細
## ユーザー機能
  - deviseを使用
  - 新規登録、ログイン、ログアウト、編集機能
  - ゲストログイン機能
  - ユーザー画像のアップロード
  - 詳細画面
  - ユーザーの一覧表示

 ## CV機能
  - CV作成、編集、削除（セクション別）機能
  - CVの非表示機能

## 投稿機能(ajax)
  - 一覧表示、詳細表示、作成、削除機能

## リプライ機能（ajax）
  - タイムラインでのリプライ投稿、リプライ削除機能(ajax)
  - 詳細画面の関連リプライ一覧表示、リプライ投稿、リプライ削除機能

## フォロー機能（ajax）
  - フォロー、フォロワーの一覧表示機能
  - タイムライン機能

## 検索機能
  - 投稿の内容を検索
  - ユーザーの検索
  - 同一画面内での複数モデルの検索（ボタン）

## ダイレクトメッセージ機能
  - 1：1のチャットルームを作成
  - ダイレクトメッセージを行っているユーザーの一覧表示
  - メッセージ送信、メッセージ削除機能（ajax）

## 通知機能
  - リプライ、フォローを受信したら通知
  - ダイレクトメッセージの通知

## テスト機能
  - RSpecを使用（テスト件数は200以上）


# 使用した主なgem
* devise ：ユーザーログイン機能
* ransack ：検索機能
* carrierwave：画像投稿
* mini_magick：画像加工
* bullet：N+1検出
* rspec-rails ：テストコード
* factory_bot_rails ：テストデータ作成
* faker ：ダミーデータ作成


# DB設計
![ER図](https://user-images.githubusercontent.com/60307311/105661620-38fb2d00-5f11-11eb-9c7e-587978581367.jpg "ER図")

# その他
ローカル環境にて、git cloneを行う場合は、Docker-composeにてビルド後に、
TailwindCSSをnpmでインストールする必要があります。

docker-compose run web npm install tailwindcss@npm:@tailwindcss/postcss7-compat @tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9

docker-compose run web yarn install --check-files