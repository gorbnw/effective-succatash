class Business < ApplicationRecord
  has_many :testimonials
  validates :name, :phone, :address, presence: true
end
