class Category < ApplicationRecord
  has_many :category_settings
  has_many :boards, through: :category_settings
  validates :name, presence: true
end
