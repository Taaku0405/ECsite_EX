class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address_date = ShippingAddress.new
    @address_dates = current_customer.shipping_addresses

  end

  def edit
    @address_date = ShippingAddress.find(params[:id])
  end

  def create
    @address_date = ShippingAddress.new(address_date_params)
    @address_date.customer_id = current_customer.id
    @address_dates = current_customer.shipping_addresses
    if @address_date.save
      flash.now[:notice] = "配送先を登録しました。"
    end
  end

  def update
    @address_date = ShippingAddress.find(params[:id])
    if @address_date.update(address_date_params)
      redirect_to shipping_addresses_path, notice: "配送先を編集しました。"
    else
      render "edit"
    end
  end

  def destroy
    @address_date = ShippingAddress.find(params[:id])
    @address_date.destroy
    @address_dates = current_customer.shipping_addresses
    flash.now[:notice] = "配送先を削除しました。"
  end

  private

  def address_date_params
    params.require(:shipping_address).permit(:postal_code, :address, :name)
  end

end
