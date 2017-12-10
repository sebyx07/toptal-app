module JoggingService
  class Report < OpenStruct
    def process
      if to_date.present?
        self.to_date = Time.zone.parse(to_date)
      else
        self.to_date = Time.zone.now
      end
      self.from_date = to_date - 7.days
      jogging_times = JoggingTime.where('created_at > ? AND created_at < ?', from_date, to_date).to_a
      self.count = jogging_times.size

      speed_list = jogging_times.map(&:average_speed).compact
      if speed_list.empty?
        self.average_speed = 0
      else
        self.average_speed = speed_list.sum / speed_list.size.to_f
      end

      distance_list = jogging_times.map(&:distance).compact

      self.distance = distance_list.sum
      self
    end

    def id
      "#{to_date.strftime('%Y-%m-%d')}-#{from_date.strftime('%Y-%m-%d')}"
    end

    def to_json
      {
        id: id,
        to_date: to_date,
        from_date: from_date,
        count: count,
        average_speed: average_speed,
        distance: distance
      }
    end
  end
end