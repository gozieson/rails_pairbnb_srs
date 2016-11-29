class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.text :address
      t.integer :user_id
      t.integer :price
      t.text :content

      t.timestamps null: false
    end
  end
end
