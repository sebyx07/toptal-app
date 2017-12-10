class UsersController < ApplicationController
  before_action :require_current_manager, except: [:login_as_user]
  before_action :require_current_admin, only: [:login_as_user]

  def index
    @pagination = pagination
    if params[:pagination].present?
      return render partial: 'users/users_list', locals: {pagination: @pagination}, layout: false
    end

    respond_to do |format|
      format.html
      format.json { render json: { users: @pagination.records }}
    end
  end

  def show
    format.json { render json: { user: User.find_by(id: params[:id]) } }
  end

  def update
    service = UserService::Update.new(params: params).process

    respond_to do |format|
      format.html { render partial: 'users/user', locals: { user: service.user }, layout: false }
      format.json { render json: { user: service.user } }
    end
  end

  def create
    service = UserService::Create.new(params: params).process
    respond_to do |format|
      format.html { render partial: 'users/user', locals: { user: service.user }, layout: false }
      format.json { render json: { user: service.user } }
    end
  end

  def destroy
    User.destroy(params[:id])
    head :ok
  end

  def pagination
    search_query =  -> (params, query) do
      query
    end

    ControlService::Pagination.new(query: User.order('created_at DESC'), params: params,
                                   search: search_query
    )
  end

  def login_as_user
    session[:user_id] = params[:user_id]
    redirect_to root_path
  end
end