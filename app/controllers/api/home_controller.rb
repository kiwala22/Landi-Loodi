class Api::HomeController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      render json: { message: "If you see this, you're in!" }
    end
end