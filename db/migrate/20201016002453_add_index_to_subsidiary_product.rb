class AddIndexToSubsidiaryProduct < ActiveRecord::Migration[6.0]
  def change
    add_index :subsidiary_products, [:product_id, :subsidiary_id], unique: true
  end
end
