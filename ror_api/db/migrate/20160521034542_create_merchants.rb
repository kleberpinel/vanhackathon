class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :prov
      t.string :pcode
      t.string :category
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
