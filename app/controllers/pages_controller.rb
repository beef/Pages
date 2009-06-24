class PagesController < ApplicationController
  
  def show
    @page = Page.published.find_by_permalink(params[:permalink])
    
    @page_title = @page.title
    @page_description = @page.description
    @page_keywords = @page.tag_list
  end
  
  def preview
    @page = Page.new(session[:page_preview])
    session[:page_preview] = nil
    render :action => "show"
  end

end
