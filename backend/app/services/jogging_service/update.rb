module JoggingService
  class Update < OpenStruct
    def process
      self.jogging_time = JoggingTime.find_by(id: params[:id])
      return false if jogging_time.nil?

      jogging_time.update!(params.permit(:distance, :time).merge(created_at: created_at))
      self
    end

    def created_at
      Time.zone.parse("#{params[:date]} #{params[:hour]}")
    end
  end
end