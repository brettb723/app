class CreateMetricReports < ActiveRecord::Migration
  def change
    create_table :metric_reports do |t|
      t.string :name
      t.date :period
      t.string :period_type

      t.timestamps
    end
  end
end
