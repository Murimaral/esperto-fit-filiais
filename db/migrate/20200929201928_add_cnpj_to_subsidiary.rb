class AddCnpjToSubsidiary < ActiveRecord::Migration[6.0]
  def change
    add_column :subsidiaries, :cnpj, :string
    add_index :subsidiaries, :cnpj, unique: true
  end
end
