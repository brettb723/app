json.array!(@metric_reports) do |metric_report|
  json.extract! metric_report, :id, :name, :period, :period_type, :value
  json.url metric_report_url(metric_report, format: :json)
end
