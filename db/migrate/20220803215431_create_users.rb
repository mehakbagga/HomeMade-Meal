class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.text :profile_img_url
      t.boolean :is_cook

      t.timestamps
    end
  end
end
