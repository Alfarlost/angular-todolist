class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json

  def angular
    render 'layouts/application'
  end

  def default_serializer_options
    {root: false}
  end
end
