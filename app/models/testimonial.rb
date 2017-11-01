  validates_presence_of :description, :message => "Description cannot be blank"
  validates :anonymous, inclusion: { in: [true, false] }
  # cannot validate boolean with presence: true method since adding a
  ## false input would technically fail the validation. use syntax below
  ## to test boolean presence validations
  validates :positive, inclusion: { in: [true, false], :message => "Please choose 'safe' or 'unsafe'"}

  has_and_belongs_to_many :tags
  has_many :votes
  belongs_to :user

  # Example: Testimonial.count({verbose: false, yelp_id: "busters-ham-house", positive: false}) => 4


  def self.count(args)
    yelp_id = args[:yelp_id]
    if args[:positive]
      count = Testimonial.count_positive(yelp_id)
      if args[:verbose]
        return "#{count} user gave praise!" if count == 1
        return "#{count} users gave praise!" if count > 0
        "No praise for this business yet"
      else
        count
      end
    else
      count = Testimonial.count_negative(yelp_id)
      if args[:verbose]
        return "#{count} user left criticism" if count == 1
        return "#{count} users left criticism" if count > 0
        "No criticism for this business yet"
      else
        count
      end
    end

  end

  def self.get_percent_pos(yelp_id)
    total = Testimonial.where(yelp_id: yelp_id).count
    return 50 if total <= 0
    ((Testimonial.count_positive(yelp_id).to_f / total.to_f) * 100).to_i
  end

  def self.count_positive(yelp_id)
    Testimonial.where(yelp_id: yelp_id, positive: true).count
  end

  def self.count_negative(yelp_id)
    Testimonial.where(yelp_id: yelp_id, positive: false).count
  end
