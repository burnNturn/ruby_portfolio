class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
  def get_quick_quote
    begin 
      @security = Security.where(symbol: app_params[:symbol]).first
    rescue 
      #TODO
    end
    @quote = @security.get_quote
    render 'js', template: 'layouts/get_quick_quote'
  end
  
  def index
    @securities = Security.none
  end

  
  private
  
    def app_params
      params.permit(:symbol, :utf8, :commit, :format)
    end
end
