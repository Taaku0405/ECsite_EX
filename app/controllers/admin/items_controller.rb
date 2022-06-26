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
      flash[:success] = "新商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      render "admin/items/new"
    end
  end 
  
  def update
    @item = Item.find(params[:id])
    @genres = Genre.all
    if @item.update(item_params)
      flash[:notice] ="商品情報を更新しました"
      redirect_to admin_items_path
    else
      render :edit
    end 
  end 
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :item_image, :genre_id)
  end
end
