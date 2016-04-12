class SiteController < ApplicationController
  before_action :authenticate_user!

  # will return all bookmarks for admin users,
  #  else, it will return only the logged in users's 
  #   bookmark list, with links to lick to the site the bookmark
  #   is storing.
  def index
    if current_user.admin? 
      @bookmarks = Bookmark.order('created_at desc')
    else
      @bookmarks = current_user.bookmarks.order('created_at desc')
    end 
  end
end
