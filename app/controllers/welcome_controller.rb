class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @messages = Message.all
  end

end
