class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :title
      t.text :description
      t.text :ingredients
      t.text :img_url
      t.float :price

      t.timestamps
    end
  end
end
