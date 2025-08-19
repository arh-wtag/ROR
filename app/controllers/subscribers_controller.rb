class SubscribersController < ApplicationController
    allow_unauthenticated_access
    before_action :set_product
    def create
        @product.subscribers.where(subscriber_params).first_or_create
        redirect_to @product, notice: "you are now subscribed."
    end

    private
    def set_product
        @product = Product.find([:product_id])
    end
    def subscriber_params
        params.expect(subscriber: [ :email ])
    end
end
