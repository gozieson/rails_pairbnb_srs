class AddToursToListings < ActiveRecord::Migration
  def change
    add_column :listings, :tours, :json
  end
end
