module JoggingService
  class Create < JoggingService::Update
    def process
      user = User.first
      self.jogging_time = JoggingTime.create!(params.permit(:distance, :time).merge(created_at: created_at, user: user))
      self
    end

    def created_at
      Time.zone.parse("#{params[:date]} #{params[:hour]}")
    end
  end
end