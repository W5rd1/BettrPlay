class ActivitiesController < ApplicationController
# notifications_controller.rb
  def index
    @activities = PublicActivity::Activity.order("created_at desc")
  end
end
