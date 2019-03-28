class CartsController < ApplicationController
  before_action :refresh_cart, only: %i(index)

  def index; end

  def create
    add_product params[:shop_id]
    redirect_to shop_carts_path
  end

  def destroy
    remove_product params[:id]
    refresh_cart
    execute_ajax
  end

  private

  def refresh_cart
    @cart = Array.new
    session[:cart].each do |product|
      @cart << Course.find_by(id: product) if product
    end
    @cart = @cart.uniq
  end

  def add_product id
    session[:cart] ||= Array.new
    session[:cart] << id
  end

  def remove_product product
    session[:cart].delete_if{|f| f == product}
  end

  def execute_ajax
    respond_to do |format|
      format.html{redirect_to shop_carts_path}
      format.js
    end
  end
end
