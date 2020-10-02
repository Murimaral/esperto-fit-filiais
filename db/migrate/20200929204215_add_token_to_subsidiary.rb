class AddTokenToSubsidiary < ActiveRecord::Migration[6.0]
  def change
    add_column :subsidiaries, :token, :string
    add_index :subsidiaries, :token, unique: true
  end
end
