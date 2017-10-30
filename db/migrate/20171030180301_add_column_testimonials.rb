class AddColumnTestimonials < ActiveRecord::Migration[5.1]
  def change
    add_column :testimonials, :yelp_id, :string
  end
end
