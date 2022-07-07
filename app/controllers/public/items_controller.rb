class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8)
    @quantity = Item.count
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    #ジャンル検索アクション
    @items = Item.where(genre_id: params[:format]).page(params[:page]).per(8) #パラメーターで取得したジャンルIDをもとにgenre_idと一致する商品の取得
    @quantity = Item.where(genre_id: params[:format]).count #検索してきた商品数をカウント
    @genres = Genre.all
    @genre = Genre.find(params[:format]) #ビューで検索したジャンル名を表示するため変数を用意
    render 'index'
  end
end
