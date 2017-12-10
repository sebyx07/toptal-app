class JoggingTimesController < ApplicationController
  before_action :require_current_user

  def index
    @pagination = pagination
    if params[:pagination].present?
      return render partial: 'jogging_times/jogging_times_list', locals: {pagination: @pagination}, layout: false
    end

    respond_to do |format|
      format.html
      format.json { render json: { jogging_times: @pagination.records }}
    end
  end

  def update
    service = JoggingService::Update.new(params: params).process

    respond_to do |format|
      format.html { render partial: 'jogging_times/jogging_time', locals: { jogging_time: service.jogging_time }, layout: false }
      format.json { render json: { jogging_time: service.jogging_time } }
    end
  end

  def create
    service = JoggingService::Create.new(params: params).process
    respond_to do |format|
      format.html { render partial: 'jogging_times/jogging_time', locals: { jogging_time: service.jogging_time }, layout: false }
      format.json { render json: { jogging_time: service.jogging_time } }
    end
  end

  def destroy
    JoggingTime.destroy(params[:id])
    head :ok
  end

  def show
    format.json { render json: { jogging_time: JoggingTime.find_by(id: params[:id]) } }
  end

  def pagination
    search_query =  -> (params, query) do
      from_date = params[:from_date]
      to_date = params[:to_date]
      if from_date.present? && to_date.present?
        from_date = Time.zone.parse(from_date)
        to_date = Time.zone.parse(to_date)
        query.where('created_at >= ? AND created_at <= ?', from_date, to_date)
      else
        query
      end
    end

    ControlService::Pagination.new(query: JoggingTime.order('created_at DESC'), params: params,
                                   search: search_query
    )
  end
end