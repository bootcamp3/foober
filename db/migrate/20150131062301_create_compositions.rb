class CreateCompositions < ActiveRecord::Migration
  def change
    create_table :compositions do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.timestamps null: false
    end
  end
end
