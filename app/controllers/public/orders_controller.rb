class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = current_customer
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

   def create
    cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.order_status = 0

    @order.save!
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.price
      order_detail.save
    end
    @address = Address.new
    @address.customer_id = current_customer.id
    @address.postal_code = params[:order][:postal_code]
    @address.address = params[:order][:address]
    @address.name = params[:order][:name]
    if @address.save!
    current_customer.cart_items.all.destroy_all
    redirect_to completed_path
    else
      render :confirmation
    end
   end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.charge = 800
    @order.total_payment = @total_price + @order.charge

      if params[:order][:select_address] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name

      elsif params[:order][:select_address] == "1"
        #登録した配送先を選択しなかった場合
        unless current_customer.addresses.exists?
          flash[:notice] = "登録済の住所が選択されていません"
          render "new"
        else
          @address = Address.find(params[:order][:address_id])
          @order.postal_code = @address.postal_code
          @order.address = @address.address
          @order.name = @address.name
        end

      elsif params[:order][:select_address] == "2"

        if params[:order][:postal_code] == "" && params[:order][:address] == "" && params[:order][:name] == ""

          flash[:notice] = "新しいお届け先が全て入力されていません"
          render "new"
        elsif params[:order][:postal_code] == ""
          flash[:notice] = "郵便番号が入力されていません"
          render "new"
        elsif params[:order][:address] == ""
          flash[:notice] = "住所が入力されていません"
          render "new"
        elsif params[:order][:name] == ""
          flash[:notice] = "宛名が入力されていません"
          render "new"
        else
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
        end
      else
         flash.now[:notice] = "住所を選択してください"
         render "new"
      end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :customer_id, :charge, :total_payment, :order_status)
  end

end