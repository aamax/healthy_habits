class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :amount
      t.string :product_id
      t.boolean :active
      t.string :partial

      t.timestamps
    end
  end
end
