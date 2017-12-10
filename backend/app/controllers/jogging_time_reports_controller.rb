class JoggingTimeReportsController < ApplicationController
  before_action :require_current_user

  def index
    @report = JoggingService::Report.new.process
  end

  def show
    @report = JoggingService::Report.new(to_date: params[:to_date]).process

    respond_to do |format|
      format.html { render partial: 'jogging_time_reports/report', locals: { report: @report }, layout: false }
      format.json { render json: { report: @report.to_json } }
    end
  end
end