require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products #the products table will be emptied out and then populated with fixtures/products.yml.

  test "products attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My title",
                          description: "This is my first book",
                          image_url: "test.jpg",
                          price: -1)
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]
    product.price = 1
    assert product.valid?
  end

  test "image url ends with .gif, .jpg, or .png" do
    good_extensions = %w{ test.gif test.png test.jpg test.JPG test.GIF test.PNG test/test.png }
    bad_extensions = %w{ test.xls test.jif test.tiff test.txt }

    good_extensions.each do |good_url|
      assert test_product(good_url).valid?, "#{good_url} should be valid"
    end

    bad_extensions.each do |bad_url|
      assert test_product(bad_url).invalid?, "#{bad_url} should be invalid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy",
                          price: 1,
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end





  private

  def test_product(image_url)
    Product.new(title: "My title", description: "Test", price: 10.00, image_url: image_url)
  end
end
