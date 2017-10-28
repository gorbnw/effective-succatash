class Testimonial < ApplicationRecord
  validates :description, presence: true
  validates :anonymous, presence: true
  validates :positive, presence: true

  has_and_belongs_to_many :tags
  has_many :votes
  belongs_to :user
  belongs_to :business


end
