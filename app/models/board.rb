class Board < ApplicationRecord
  has_many :comments
  has_many :users, through: :comments
  has_many :category_settings
  has_many :categories, through: :category_settings
  validates :title, presence: true
end
