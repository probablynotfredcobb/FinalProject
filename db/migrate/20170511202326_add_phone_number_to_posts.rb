class AddPhoneNumberToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :phone_number, :string
  end
end
