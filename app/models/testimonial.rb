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

  # Example: Testimonial.count({verbose: false, business_id: 1, positive: false}) => 4


  def self.count(args)
    business_id = args[:business_id]
    if args[:positive]
      testimonials = Testimonial.where(business_id: business_id, positive: true)
      count = testimonials.count
      if args[:verbose]
        return "#{count} user gave praise!" if count == 1
        return "#{count} users gave praise!" if count > 0
        "No praise for this business yet"
      else
        count
      end
    else
      testimonials = Testimonial.where(business_id: business_id, positive: false)
      count = testimonials.count
      if args[:verbose]
        return "#{count} user left criticism" if count == 1
        return "#{count} users left criticism" if count > 0
        "No criticism for this business yet"
      else
        count
      end
    end

  end


end
