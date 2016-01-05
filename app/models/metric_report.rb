class MetricReport < ActiveRecord::Base
  METRICS = %w(
    trips_scheduled(count)
    trips_performed(count)
    trips_billed(count)
    trips_paid(count)
    on_time_performance(count)
    trips_scheduled(dollars)
    trips_performed(dollars)
    trips_billed(dollars)
    trips_paid(dollars)
    on_time_performance(dollars)
  )

  class << self
    def names
      pluck(:name).uniq.sort {|a, b| METRICS.index(a.dehumanize) <=> METRICS.index(b.dehumanize)}
    end
    def months
      where(period_type: 'month').order(period: :asc).pluck(:period).uniq
    end
    def week_ends
      where(period_type: 'week').order(period: :asc).pluck(:period).uniq
    end
  end
end
