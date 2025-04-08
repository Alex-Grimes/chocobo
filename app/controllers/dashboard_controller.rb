class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @published_posts = current_user.posts.where(published: true).order(published_at: :desc)
    @drafts = current_user.posts.where(published: false).order(updated_at: :desc)
  end
end
