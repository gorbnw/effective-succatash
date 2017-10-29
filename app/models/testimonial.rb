class Testimonial < ApplicationRecord
  validates_presence_of :description, :message => "Description cannot be blank"
  validates :anonymous, inclusion: { in: [true, false] }
  # cannot validate boolean with presence: true method since adding a
  ## false input would technically fail the validation. use syntax below
  ## to test boolean presence validations
  validates :positive, inclusion: { in: [true, false], :message => "Please choose 'safe' or 'unsafe'"}

  has_and_belongs_to_many :tags
  has_many :votes
  belongs_to :user
  belongs_to :business


end
