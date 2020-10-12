class AddSubsidiaryRefToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles, :subsidiary, foreign_key: true
  end
end
