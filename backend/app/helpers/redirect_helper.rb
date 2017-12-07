module RedirectHelper
  def redirect_to_ajax(path)
    render json: {redirect_to: url_for(path)}
  end
end