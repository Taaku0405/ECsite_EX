class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    order = @order_detail.order
    #すべての商品の準備が出来たらオーダーステータスを発送準備中に変更
    if order.order_details.count == order.order_details.where(production_status: 3).count
      order.update(order_status: 3)
    #入金確認が取れたら自動的に製作ステータスを製作待ちに変更
    elsif @order_detail.production_status == "working"
      order.update(order_status: 2)
    end
    redirect_to admin_order_path(@order_detail.order_id)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
  
end
