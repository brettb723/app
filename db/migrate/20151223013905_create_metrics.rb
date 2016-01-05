class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.date :measurement_date
      t.string :name
      t.string :metric_type
      t.string :agency
      t.float :numerator
      t.float :denominator

      t.timestamps
    end
  end
end
