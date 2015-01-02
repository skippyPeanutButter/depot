class Product < ActiveRecord::Base

  validates :title, :description, :image_url, presence: true

  validates :title, uniqueness: true, length: { minimum:10 }

  validates_numericality_of :price, greater_than_or_equal_to: 0.01,
                            message: "must be a number greater than or equal to 0.01"

  validates :image_url, allow_blank: true, format: {
      with: %r(\.(gif|jpg|png)\Z)i,
      message: "must be a URL for GIF, JPG or PNG image."
  }
end
