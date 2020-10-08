class AddSubsidiaryToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :subsidiary, null: false, foreign_key: true
  end
end
