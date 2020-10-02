class ProductsController < ApplicationController
  def index; end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: t('controllers.product.created')
    else
      flash.now[:alert] = t('controllers.product.creation_failed')
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :min_price)
  end
end
