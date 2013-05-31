class PagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:home, :show]
  skip_before_filter :verify_login
  #before_filter :superusers_only, :except=>[:home,:show]

  skip_authorization_check

  def show
    page_name = params[:id]

    if page_name.nil?
      redirect_to root_path
    else
      if page_name == "home"
        render "pages/partials/home"
      elsif page_name == "different"
        render "pages/partials/different"
      elsif page_name == "meet_cathy"
        render "pages/partials/meet_cathy"
      elsif page_name == "is_this_you"
        render "pages/partials/is_this_you"
      elsif page_name == 'microscopy'
        render "pages/partials/microscopy"
      elsif page_name == 'events'
        render "pages/partials/events"
      elsif page_name == 'cleanse'
        render "pages/partials/cleanse"
      elsif page_name == 'coaching'
        render "pages/partials/coaching"
      elsif page_name == 'construction'
        render "pages/partials/construction"
      else
        @page = Page.find_by_name(page_name)
        @page ||= Page.find(page_name) rescue nil

        if @page.nil?
          redirect_to "/", alert: "Page Not Found"
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
        redirect_to page_url(@page.id), :notice => "Page created."
      else
        render :new
      end
    else
      redirect_to root_path, :alert => "You are not authorized to create this page"
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
      flash.notice = "Page Updated."
    else
      redirect_to root_path, :alert => "You are not authorized to update this page"
    end
  end

  def destroy
    if admin_user?
      @page = Page.find(params[:id])
      if @page.destroy
        redirect_to pages_path, :notice => "This Page was destroyed."
      else
        redirect_to pages_path, :alert => "Error deleting page: " + @page.name
      end
    else
      redirect_to root_path, :alert => "You are not authorized to delete this page"
    end
  end


end
