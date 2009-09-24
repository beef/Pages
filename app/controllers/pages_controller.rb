class PagesController < ApplicationController
  include Beef::Pages::HelperMethods

  def show
    @page = Page.published.find_by_permalink(params[:id])
    
    @page_title = @page.title
    @page_description = @page.description
    @page_keywords = @page.tag_list
    
    render :template => "pages/templates/#{(@page.template || get_template_names.first)}"
  end
  
  def preview
    @page = Page.new(session[:page_preview])
    @page.id = 0
    @page.published_at = Time.now
    @page.created_by = current_user if @page.created_by.nil?
    session[:page_preview] = nil
    render :template => "pages/templates/#{(@page.template || get_template_names.first)}"
  end

end
