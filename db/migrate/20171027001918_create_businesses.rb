class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :phone
      t.text :address

      t.timestamps null: false
    end
  end
end
