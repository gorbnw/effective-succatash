class CreateTestimonials < ActiveRecord::Migration[5.1]
  def change
    create_table :testimonials do |t|
      t.text :description
      t.boolean :anonymous
      t.boolean :positive
      t.belongs_to :business
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
