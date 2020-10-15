class HomeController < ApplicationController
  before_action :must_be_admin

  def index; end
end
