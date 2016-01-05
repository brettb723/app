require 'csv'
class Metric < ActiveRecord::Base

	class << self

		def import_csv(file=nil)
			csv_data = nil
			begin
				storage = Fog::Storage.new(
					provider: ENV['FOG_PROVIDER'],
					aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
					aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
				)
				remote_file = storage.
					directories.
					find {|dir| dir.key == ENV["AWS_BUCKET"]}.
					files.
					find {|file| file.key == ENV["AWS_PATH"]}
				csv_data = remote_file.body
			rescue => e
				file ||= Rails.root.join('public', 'flowdata.csv')
				# TODO revise in the future to do in a stream fashion (not loading all to memory at once)
				csv_data = File.open(file, 'r') {|f| f.read}
			end
			data = CSV.parse(csv_data, headers: true, col_sep: "\t")
			puts 'data.inspect'
			puts data.to_a.inspect
			if (Metric.count == 0)
				import_without_validations_or_callbacks(data.headers, data.to_a.drop(1)) #drop header
			else
				data.map(&:to_hash).each do |attributes|
					Metric.find_or_create_by(attributes)
				end
			end

			# metrics = [
			# 	"TripsScheduled",
			# 	"TripsPerformed",
			# 	"TripsBilled",
			# 	"TripsPaid",
			# 	"DaysToCash",
			# 	"OnTimePerformance",
			# ]
			#
			columns = [
	            "Measurement",
				"Trend"
	        ] + months

			metric_types = ['Count', 'Dollars']
			metric_types.each do |metric_type|
				calculateTableData(metric_type).each do |summary|
					['month', 'week'].each do |period_type|
						summary[period_type].each do |key, value|
							if period_type == 'month' && key.match(/\d{4}-\d{2}/)
								date_parts = key.split('-')
								year = date_parts.first
								month = date_parts.last
								period = Date.new(year.to_i, month.to_i)
							elsif period_type == 'week'
								period = key
							end
							MetricReport.find_or_create_by(
								name: summary['Measurement'],
								period_type: period_type,
								period: period,
								value: value
							)							
						end
					end
				end
			end
		end

		private
		# TODO update naming conventions to Ruby. This was converted from JavaScript
		def thisYear
			@this_year ||= Date.current.year
		end

		def rawData
			@raw_data ||= Metric.all.map do |metric|
				attrs = metric.attributes.clone
				attrs.delete('id')
				attrs
			end.map(&:values)
		end

		def months
			@months ||= Metric.send(:rawData).map(&:first).reject {|date| date.nil?}.map {|date| "#{date.year}-#{date.month.to_s.rjust(2, padstr='0')}"}.uniq.sort
		end

		def week_ends
			@week_ends ||= Metric.send(:rawData).map(&:first).reject {|date| date.nil?}.map do |date|
				week_end(date)
			end.uniq.sort
		end

		def metrics
			@metrics ||= Metric.send(:rawData).map(&:second).reject {|metric| metric.nil?}.uniq.sort
		end

		def week_end(date)
			date + (7 - date.wday)
		end

		def calculateTableData(metricType)
			metrics.map do |metric|
				rowHash = months.reduce({'month' => {}}) do |output, month|
					accumulator = accumulate_metric_type_data_matching_period(metricType, metric) do |row|
						monthNumStr = (month.split('-').last)
						row[0].to_s.starts_with?("#{thisYear}-#{monthNumStr}-")
					end
					value = rawData.reduce(0, &accumulator)
					output['month'][month] = value != 0 && !!value ? value : 'N/A'
					output
				end
				rowHash = week_ends.reduce(rowHash.merge('week' => {})) do |output, week_end|
					accumulator = accumulate_metric_type_data_matching_period(metricType, metric) do |row|
						week_end(row[0]) == week_end
					end
					value = rawData.reduce(0, &accumulator)
					output['week'][week_end] = value != 0 && !!value ? value : 'N/A'
					output
				end
				rowHash['Measurement'] = metric.humanize + ' ('+metricType+')';
				rowHash;
			end
		end

		def accumulate_metric_type_data_matching_period(metricType, metric, &period_matcher)
			-> (outcome, row) {
				return outcome if row.empty?
				metricMatch = row[1] == metric
				metricTypeMatch = row[2] == metricType
				valueToAdd = row[4].to_f
				period_matcher.call(row) && metricMatch && metricTypeMatch ? (outcome + valueToAdd) : outcome
			}
		end


	end

end
