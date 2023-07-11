class Order < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  validates :address, presence: true
  validates :recipient, presence: true
end
