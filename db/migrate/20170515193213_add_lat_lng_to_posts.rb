class AddLatLngToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :lat, :string
    add_column :posts, :lng, :string
    # remove_column :posts, :avatar 
  end
end
