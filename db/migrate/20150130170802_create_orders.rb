class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :chef_id
      t.integer :recipe_id
      t.string :status
      t.timestamps null: false
    end
  end
end
