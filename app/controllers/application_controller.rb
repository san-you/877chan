class ApplicationController < ActionController::Base
  if Rails.env.development?
    rescue_from Exception,                        with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
    rescue_from ActionController::RoutingError,   with: :_render_404
  end

  def after_sign_in_path_for(resource)
    boards_path
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

    def _render_404(e = nil)
      logger.info "Rendering 404 with exception: #{e.message}" if e
  
      if request.format.to_sym == :json
        render json: { error: '404 error' }, status: :not_found
      else
        render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
      end
    end
  
    def _render_500(e = nil)
      logger.error "Rendering 500 with exception: #{e.message}" if e
  
      if request.format.to_sym == :json
        render json: { error: '500 error' }, status: :internal_server_error
      else
        render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
      end
    end
end
