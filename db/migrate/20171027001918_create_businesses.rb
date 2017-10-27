class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.text :address, null: false

      t.timestamps null: false
    end
  end
end
