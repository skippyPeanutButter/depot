class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @time = Time.now
    @counter = increment_count
  end


  private
    def increment_count
      session[:counter] ||= 0
      session[:counter] += 1
    end
end
