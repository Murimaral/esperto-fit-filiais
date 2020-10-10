class AddIndexToSubsidiaryPlan < ActiveRecord::Migration[6.0]
  def change
    add_index :subsidiary_plans, [:plan_id, :subsidiary_id], unique: true
  end
end
