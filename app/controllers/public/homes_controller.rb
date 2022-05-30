class Public::HomesController < ApplicationController

   def top
    @genres = Genre.all
    #登録された商品を新しい順に4つ取得
    @items = Item.where(is_active: true).order('id DESC').limit(4)
   end

   def about
   end
end
