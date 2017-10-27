class Tag < ApplicationRecord
  has_and_belongs_to_many :testimonials
  validates :description, presence: true
end
