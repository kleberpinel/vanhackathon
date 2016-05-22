class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :image_url

      t.integer :merchant_id

      t.timestamps null: false
    end
  end
end
