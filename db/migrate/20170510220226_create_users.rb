class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :session_id
      t.string :phone_number

      t.timestamps
    end
  end
end
