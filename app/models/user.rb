class User < ApplicationRecord
  has_many :testimonials
  has_many :votes
end
