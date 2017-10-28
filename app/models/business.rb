class Business < ApplicationRecord
  validates :name, :phone, :address, presence: true
  has_many :testimonials

  def count_praise
    count = self.testimonials.where(positive: true).count
    return "#{count} user gave praise!" if count == 1
    return "#{count} users gave praise!" if count > 0
    "No praise for this business yet"

  end

  def count_criticism
    count = self.testimonials.where(positive: false).count
    return "#{count} user left criticism" if count == 1
    return "#{count} users left criticism" if count > 0
    "No criticism for this business yet"
  end

end
