class JoggingTimesController < ApplicationController
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
    JoggingService::Update.new(params: params).process
    head :ok
  end

  def create
    service = JoggingService::Create.new(params: params).process
    render partial: 'jogging_times/jogging_time', locals: {jogging_time: service.jogging_time}, layout: false
  end

  def destroy
    JoggingTime.destroy(params[:id])
    head :ok
  end

  def pagination
    search_query =  -> (params, query) do
      query
    end

    ControlService::Pagination.new(query: JoggingTime.order('created_at DESC'), params: params,
                                   path: -> (param, hash) { dashboard_entities_path(param, hash) },
                                   search: search_query
    )
  end
end