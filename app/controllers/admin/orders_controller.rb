class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Ordere.order("order_status ASC").page(params[:page]).per(15)
  end

  def show
    @order = Order.find(params[:id])
    @order_customer_name = @order.customer.family_name + @order.customer.first_name
    @total = @order.order_details.inject(0) {|sum, order_detail| sum + order_detail.subtotal}
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    #入金確認が取れたら自動的に製作ステータスを製作待ちに変更
    if @order.order_status == "payment_confirmed"
      @order.order_details.update_all(production_status: 1)
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
