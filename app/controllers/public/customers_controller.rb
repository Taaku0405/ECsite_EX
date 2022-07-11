class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def quit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to customer_path, notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  def withdraw
    #会員のis_deletedにtrueを入れて更新
    current_customer.update(is_deleted: true)
    #ログイン情報をリセット（ログインされたままに
    reset_session
    redirect_to root_path, notice: "退会しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
  
end
