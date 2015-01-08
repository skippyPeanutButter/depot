class Order < ActiveRecord::Base
  belongs_to :pay_type
  has_many :line_items, dependent: :destroy

  validates :name, :email, :address, presence: true

  validates :pay_type, inclusion: PAYMENT_TYPES = ["Check", "Credit Card", "Purchase order"]

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil # set to nil so item is not destroyed with cart
      line_items << item
    end
  end

end
