class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.string :token
      t.string :customer_name
      t.string :customer_cpf
      t.date :valid_thru

      t.timestamps
    end
  end
end
