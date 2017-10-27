class Business < ApplicationRecord
  has_many :testimonials

  def count_praise
    self.testimonials.where(positive: true).count
  end

  def count_criticism
    self.testimonials.where(positive: false).count
  end

end
