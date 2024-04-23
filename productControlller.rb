class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    product = Product.new(product_params)
    if product.save
      WebhookService.new(product).notify_all
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      WebhookService.new(product).notify_all
      render json: product
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end