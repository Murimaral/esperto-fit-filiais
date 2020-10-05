class AddMinimumPeriodToPlan < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :minimum_period, :integer
  end
end
