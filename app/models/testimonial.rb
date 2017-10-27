class Testimonial < ApplicationRecord
  
  def positive_criticism_points
    self.count('positive')
  end
end
