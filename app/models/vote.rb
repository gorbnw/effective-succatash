class Vote < ApplicationRecord
  belongs_to :testimonial
  belongs_to :user
end
