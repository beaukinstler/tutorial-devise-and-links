class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /bookmarks
  # GET /bookmarks.json
  def index

    if current_user.admin? 
      @bookmarks = Bookmark.all
    else
      @bookmarks = current_user.bookmarks.all
    end
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    # @bookmark = Bookmark.new
    # TODO: Investigate if the above code
    # is better than the below code.  Both seems to 
    # work at this point
    @bookmark = current_user.bookmarks.build()
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create

    # Create a bookmark using the current user ID
    # this is required and validated by the
    # bookmarks.rb model

    @bookmark = current_user.bookmarks.build(bookmark_params)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end

      # TODO: add a redirect back to the new page
      # TODO: make the flash message persistant to the 
      #   to the new_bookmark_url to show the 
      #   record was added successfully.
      #   
      #redirect_to new_bookmark_path and return
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      unless @bookmark = current_user.bookmarks.where(id: params[:id]).first
        flash[:alert] = 'Bookmark not found!'
        redirect_to root_url
      end

      #@bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :url)
    end
end
