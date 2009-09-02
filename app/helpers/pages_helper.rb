module PagesHelper
  def related_pages(taggable, limit = 3, &block)
    pages = Page.published.all(taggable.related_search_options(:tags, Page, :limit => limit))
    return if pages.empty?
    yield(pages)
  end
  
  
  def sub_pages_list(permalink)
    page = Page.find_by_permalink(permalink)
    return if page.nil?
    page_items = page.children.published.collect do |sub_page|
      content_tag( :li, link_to( h(sub_page.title), page_path(sub_page.permalink)))
    end
    content_tag :ul, page_items.join unless page_items.empty? 
  end

end
