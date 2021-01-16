class Image < ApplicationRecord
  validates_presence_of :name, :description, :price, :url, :inventory
  validates_numericality_of :inventory, greater_than: 0
  validates_numericality_of :price, greater_than: 0

  belongs_to :user
end
