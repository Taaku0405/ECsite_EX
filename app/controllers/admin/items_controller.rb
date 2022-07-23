class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @item = Item.new
    @genres = Genre.all
  end 
  
  def index
    @items = Item.all.page(params[:page]).per(10)
  end 
  
  def show
    @item = Item.find(params[:id])
  end 
  
  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end 
  
  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
      flash[:notice] = "新商品を登録しました"
    else
      render "admin/items/new"
      flash[:notice] = "商品登録できません。空白の場合は登録できません"
    end
  end 
  
  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
    if @item.update(item_params)
      redirect_to admin_items_path
      flash[:notice] ="商品情報を更新しました"
    else
      render :edit
      flash[:notice] = "商品情報の更新に失敗しました。再度確認をお願いします"
    end 
  end 
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :item_image, :genre_id)
  end
end
