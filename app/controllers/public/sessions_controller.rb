# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #サインイン前にcustomer_stateを実行する。
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

   protected
#会員情報を確認するコマンド
  def customer_state
    #customerテーブルからemail情報をもとにcustomerのデータを引き出す
    @customer = Customer.find_by(email: params[:customer][:email])
    #データが引き出せない場合は、処理を終了させる。
    return if !@customer
    #パスワードがあってるいる、かつ、退会ステータスがtrueの場合処理を実行する
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_customer_registration_path
    end
  end

end
