class Testimonial < ApplicationRecord
  has_and_belongs_to_many :tags
  has_many :votes

  def count
  end
end
