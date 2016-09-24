class CreateSofas < ActiveRecord::Migration
  def change
  	create_table :couches do |t|
      t.string :family_name, null: false
      t.integer :product_number
      t.string :fabric
      t.string :img_link

      t.timestamps(null: false)
    end
  end
end
