class SiteController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin? 
      @bookmarks = Bookmark.order('created_at desc')
    else
      @bookmarks = current_user.bookmarks.order('created_at desc')
    end 
  end
end
