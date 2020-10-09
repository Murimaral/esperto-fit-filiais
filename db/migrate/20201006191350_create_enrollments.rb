class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.string :token
      t.string :customer_name
      t.string :customer_cpf
      t.string :email
      t.decimal :price
      t.integer :status, default: 0
      t.date :valid_thru
      t.references :subsidiary_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
