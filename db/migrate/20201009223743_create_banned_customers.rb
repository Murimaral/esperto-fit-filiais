class CreateBannedCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :banned_customers do |t|
      t.text :reason, null: false
      t.datetime :banned_at, null: false
      t.references :user, null: false, foreign_key: true
      t.string :cpf, index: { unique: true }, null: false

      t.timestamps
    end
  end
end
