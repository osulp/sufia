class ErrorsController < ApplicationController
  def routing
    render_routing_error("Route not found: /#{params[:error]}")
  end

  private

    def render_routing_error(exception)
      logger.error("Rendering 404 page due to exception: #{exception.inspect} - #{exception.backtrace if exception.respond_to? :backtrace}")
      render '404', layout: "error", status: 404
    end
end
