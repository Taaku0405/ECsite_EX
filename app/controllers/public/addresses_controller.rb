class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address_date = Address.new
    @address_dates = current_customer.addresses

  end

  def edit
    @address_date = Address.find(params[:id])
  end

  def create
    @address_date = Address.new(address_date_params)
    @address_date.customer_id = current_customer.id
    @address_dates = current_customer.addresses
    if @address_date.save
      flash.now[:notice] = "配送先を登録しました。"
    end
  end

  def update
    @address_date = Address.find(params[:id])
    if @address_date.update(address_date_params)
      redirect_to addresses_path, notice: "配送先を編集しました。"
    else
      render "edit"
    end
  end

  def destroy
    @address_date = Address.find(params[:id])
    @address_date.destroy
    @address_dates = current_customer.addresses
    flash.now[:notice] = "配送先を削除しました。"
  end

  private

  def address_date_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
