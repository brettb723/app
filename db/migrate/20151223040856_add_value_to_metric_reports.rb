class AddValueToMetricReports < ActiveRecord::Migration
  def change
    add_column :metric_reports, :value, :float
  end
end
