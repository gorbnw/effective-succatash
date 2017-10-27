class Testimonial < ApplicationRecord
  validates :description, presence: true
  validates :anonymous, presence: true
  validates :positive, presence: true
  has_and_belongs_to_many :tags
  has_many :votes

  def count
  end
end
