namespace :data do
  desc "Clears metric data"
  task :clear => :environment do
    Metric.delete_all
    MetricReport.delete_all
  end

  desc "Imports metric data for Count and Dollars, including reporting summary work"
  task :import, [:file] => [:environment] do |t, args|
    Metric.import_csv(args[:file]) #TODO PICK SPECIFIC FILE
  end

  desc "Clears and Imports metric data for Count and Dollars, including reporting summary work"
  task :clear_and_import, [:file] => [:environment] do |t, args|
    Metric.delete_all
    MetricReport.delete_all
    Metric.import_csv(args[:file]) #TODO PICK SPECIFIC FILE
  end
end
