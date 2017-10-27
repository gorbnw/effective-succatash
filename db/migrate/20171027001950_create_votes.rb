class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.belongs_to :testimonial
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
