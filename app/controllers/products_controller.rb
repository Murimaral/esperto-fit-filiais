class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: t('.created')
    else
      flash.now[:alert] = t('.not_created')
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :min_price, :image)
  end
end
