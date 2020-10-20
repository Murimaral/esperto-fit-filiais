class SubsidiaryProductsController < ApplicationController
  before_action :set_subsidiary_products, only: %i[new]

  def new
    @subsidiary_product = SubsidiaryProduct.new
  end

  def create
    @subsidiary_product = SubsidiaryProduct.new(subsidiary_product_params)
    return redirect_to subsidiary_path(params[:subsidiary_id]), notice: t('.created') if @subsidiary_product.save

    set_subsidiary_products
    flash.now[:alert] = t('.not_created')
    render :new
  end

  private

  def subsidiary_product_params
    params.require(:subsidiary_product).permit(:product_id, :final_price, :status)
          .merge(subsidiary_id: params[:subsidiary_id])
  end

  def set_subsidiary_products
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @products = Product.where.not(id: @subsidiary.products.ids)
  end
end
