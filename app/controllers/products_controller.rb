class ProductsController < ApplicationController
  around_action :switch_locale

  def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
  end

  allow_unauthenticated_access only: %i[ show index ]
  before_action :set_product, only: %i[ edit update show destroy ]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save 
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @product.destroy
    redirect_to product_path
  end
  
  private
    def set_product
      @product = Product.find(params[:id])
    end
    
    def product_params
      params.expect(product: [ :name, :description, :featured_image, :inventory_count])
    end
end
