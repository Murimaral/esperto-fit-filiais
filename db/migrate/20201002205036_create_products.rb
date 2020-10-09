class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, index: { unique: true }, null: false
      t.text :description, null: false
      t.decimal :min_price, null: false

      t.timestamps
    end
  end
end
