class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    #カートの中に表示された商品idがあるか確認
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item.present?
       #商品がある場合、保存されている個数と入力された個数を数値に変換して足す
      @cart_item.amount += params[:cart_item][:amount].to_i
    else
      #商品がない場合、新しく作成
      @cart_item = current_customer.cart_items.new(cart_item_params)
      @cart_item.item_id = cart_item_params[:item_id]
    end

    if @cart_item.save
      flash[:notice] = "カートに商品が追加されました。"
      redirect_to cart_items_path
    else
      redirect_to request.referer, notice: "個数を選択してください"
    end
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "商品の個数が変更されました。"
    redirect_to cart_items_path(@cart_item.id)
  end

  def empty
    #カート内商品を全て削除
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    flash[:notice] = "全ての商品が削除されました。"
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    flash.now[:notice] = "商品が削除されました。"
    redirect_to request.referer
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
