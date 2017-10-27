class CreateJoinTableTagsTestimonials < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tags, :testimonials do |t|
      t.index [:tag_id, :testimonial_id]
      t.index [:testimonial_id, :tag_id]
    end
  end
end
