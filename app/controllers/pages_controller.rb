class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only=>[:home,:show]
  skip_before_filter :verify_login
  #before_filter :superusers_only, :except=>[:home,:show]

  skip_authorization_check

  def show
    page_name = params[:id]

    if page_name.nil?
      redirect_to root_path
    else

      if page_name == "different"
        render "pages/partials/different"
      else
        @page = Page.find_by_name(page_name)
        @page ||= Page.find(page_name)

        if @page.nil?
          @content = "<h1>Page Not Found.</h1>"
          @title = "NOT FOUND"
        else
          @content = @page.content
          @title = @page.title
        end
      end
    end
  end

  def index
    if admin_user?
      @pages = Page.all
    else
      redirect_to root_path, :alert => "You are not authorized to view this page"
    end
  end

  def new
    if admin_user?
      @page = Page.new
    else
      redirect_to root_path, :alert => "You are not authorized to view this page"
    end
  end

  def edit
    if admin_user?
      @page = Page.find(params[:id])
    else
      redirect_to root_path, :alert => "You are not authorized to view this page"
    end
  end

  def create
    if admin_user?
      @page = Page.new(params[:page])
      if @page.save
        redirect_to page_url(@page.id)
      else
        render :new
      end
    else
      redirect_to root_path, :alert => "You are not authorized to view this page"
    end
  end

  def update
    if admin_user?
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])

    if params[:commit] == "Update & Continue Editing"
      render params[:raw]=='y' ? :raw_edit : :edit
    elsif @page.name == "HOME"
      redirect_to "/"
    else
      redirect_to page_url(@page.name.downcase)
    end
    else
      redirect_to root_path, :alert => "You are not authorized to view this page"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      redirect_to pages_path, :notice=> "This Page was destroyed."
    else
      redirect_to pages_path, :alert=> "Error deleting page: " + @page.name
    end

  end
end
