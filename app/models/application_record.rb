require_relative 'YelpHelper'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
