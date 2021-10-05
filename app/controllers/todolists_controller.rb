class TodolistsController < ApplicationController
   def new
     #Viewへ渡すためのインスタンス変数に空のモデルオブジェクトを生成する．
     @list = List.new
#左辺:@listの名前はなんでも良い。代入できる箱があれば良い。ただ、共同開発の観点で類似の名前を付けた方がよい

   end
#インスタンス変数とはコントローラーからビューに情報を渡すための入れ物。
#html.erbで使わない、つまりViewで使わなければ@はいらない。html.erbはViewで行われているもの。

#アクションを呼び出された場合はアクション処理→アクション同名.html.erbの処理が行われる

 def create
   #代入は右から読んだ方が何を言いたいかが分かりやすい

   # 1.データを新規登録するためのインスタンス作成
   #Listモデルにデータを送るための空箱を作成してねという命令
   #後ろに(list_params)があるので空き箱にコントローラー内のlist_paramsに飛んで、値を代入
   list = List.new(list_params)

   # 2.データをデータベースに保存するためのsaveメソッド実行
   #lists(テーブル)に1レコード分のデータを保存
   #モデルでセーブ(データベースをセーブできるのはモデルだけ。モデルはセーブするところ。)
   list.save

   # 3.トップ画面へリダイレクト(webページから別のwebページに移動すること)
   #詳細画面へリダイレクト
   #保存した1レコード分のデータのid番号のページに遷移
   redirect_to todolist_path(list.id)
   #名前付きルートで定義する場合、（Prefixの値:名前付きルートのこと）_pathで記述

 #Viewへの受け渡しが必要ないのでcreate アクションのlistに@は不要

 end


 def index
  @lists = List.all
  #Listはlist.rbファイルのクラス名。Listモデルのこと
  #Listモデルを通してデータベースからすべてのデータを引っ張ってきてインスタンス変数@listにいれる。
  #名前は引っ張ってきた情報の多さでつける。全てなので複数形,@list[s]。
  #@lists→listsにするとローカル変数になってしまいViewへの受け渡しができなくなる。
 end
 #アクションは同じ名前のviewに飛ぶ。なのでindex.html.erbに行く。
 #ディレクトリの名前とコントローラーの名前には関連性がある。


 def show
  @list = List.find(params[:id])
 end
 #@listというインスタンス変数を定義して、Listモデルを通して1つのidに紐づく情報を取得する。
 #1つの情報なので、@list,単数形　になっている。
 #モデルとデータベースは常につながっている

 def edit
  @list = List.find(params[:id])
 end

 def update
  list = List.find(params[:id])
  list.update(list_params)
  redirect_to todolist_path(list.id)
  #60行目のidの値が62行目のlist.id(listのid)の引数として代入される
 end

 def destroy
  list = List.find(params[:id]) #id番号の1レコード（データ)をデータベースを通してListモデルから取得してlist（名前はなんでも良い)に代入
  list.destroy #該当レコード削除
  redirect_to todolists_path #投稿一覧画面へリダイレクト

 end

 private
 # ストロングパラメータ
 def list_params
   params.require(:list).permit(:title, :body, :image)
 end
#list_paramsというメソッドを定義
#ストロングパラメータにはモデル名_paramsという命名が一般

#2行目のparams　送られてきた値を受け取るためのメソッド
#require(:モデル名)　どのモデルの情報かを指定。[require：要求するという意味]
#permit(:カラム名)　許可するカラム名を指定する。

#privateがないと外部からlist_paramsアクションと認識されてしまい外部からアクセスできてしまう
#privateの下に書くことでコントローラー内のみ使用可能になる。ハッキング防止です。

#コントローラーからViewへなにかを送る際は、(下へ続く)
#インスタンス変数を用いるが逆は、絶対にparamsという箱に入れられてくる。
#なのでparamsをまず開いてあげる必要があるため先に入力する。
#require(list)のlistはnew.html.erbの<% ... model:@list...%>のmodel:@listと関係がある
#permitで取り出すのはそのファイル内のtitleとbodyになる

#Amazonでもの(PS5)を買った時のたとえ
#外箱(params)があり、PS5の箱(list)があり中にコントローラーや本体(title,body)があってそれを順次開けていく。

end