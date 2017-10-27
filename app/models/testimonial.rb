class Testimonial < ApplicationRecord
  has_and_belongs_to_many :tags
  has_many :votes
  belongs_to :user
  belongs_to :business

  def count_praise(business_id)
    self.where(business_id: business_id).where(positive: true).count
  end

  def count_criticism(business_id)
    self.where(business_id: business_id).where(positive: false).count
  end
end
