class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
