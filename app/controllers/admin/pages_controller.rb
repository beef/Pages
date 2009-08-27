class Admin::PagesController < Admin::BaseController
  include Beef::Pages::HelperMethods
  helper_method :get_template_names

  def index
    if params[:page_id].nil?
      @pages = Page.top
    else
      @parent = Page.find(params[:page_id])
      @pages = @parent.children
    end
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  def new
    @page = Page.new( :parent_id => params[:page_id] )
    
    render :action => 'show'
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    @page.updated_by = @page.created_by = current_user

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html {
          if params[:page].nil?
            redirect_to(admin_pages_url)
          else
            redirect_to(admin_page_pages_url(@page.parent))
          end
        }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.updated_by = current_user
  
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html {
          if params[:page].nil?
            redirect_to(admin_pages_url)
          else
            redirect_to(admin_page_pages_url(@page.parent))
          end
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
  
    respond_to do |format|
      format.html {
          if params[:page].nil?
            redirect_to(admin_pages_url)
          else
            redirect_to(admin_page_pages_url(@page.parent))
          end
      }
      format.xml  { head :ok }
    end
  end
  
  def preview    
    session[:page_preview] = params[:page]
  end
  
  def feature
    @page = Page.find(params[:id])
    if request.put?
      if params[:spot] == 'remove'
        @page.features.delete_all
      else
        @page.feature_at! params[:spot]
      end
      flash[:notice] = 'Page has been featured'
      redirect_to admin_pages_path
    end
  end

  def move_up
    Page.find(params[:id]).move_higher
    redirect_to :back
  end

  def move_down
    Page.find(params[:id]).move_lower
    redirect_to :back
  end

end
