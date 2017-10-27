class Business < ApplicationRecord
  has_many :testimonials

  def count_praise
    count = self.testimonials.where(positive: true).count
    return count if count > 0
    "No praise for this business yet"

  end

  def count_criticism
    count = self.testimonials.where(positive: true).count
    return count if count > 0
    "No criticism for this business yet"
  end

end
