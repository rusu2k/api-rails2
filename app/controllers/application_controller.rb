class ApplicationController < ActionController::API
    include Pundit::Authorization
    include ActionController::MimeResponds

    respond_to :json

    protected

    def authenticate_user!
        
        unless user_signed_in?
            render json: { message: "User not authenticated" }, status: :unauthorized
        end
    end
end
