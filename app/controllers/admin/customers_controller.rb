class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    @customer_name = @customer.family_name + @customer.first_name
  end

  def update
    @customer =Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました。"
    else
       #名前をブランクで更新した場合、名前が表示されなくなるため、一度、会員情報を引き出し、変数に設定した。
      customer =Customer.find(params[:id])
      @customer_name = customer.family_name + customer.first_name
      render "edit"
    end 
  end

  def orders
    @customer = Customer.find(params[:customer_id])
    @customer_name = @customer.family_name + @customer.first_name
    @orders = @customer.orders.order("order_status ASC").page(params[:page]).per(15)
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
