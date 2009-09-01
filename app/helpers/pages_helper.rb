module PagesHelper
  def related_pages(taggable, limit = 3, &block)
    pages = Page.published.all(taggable.related_search_options(:tags, Page, :limit => limit))
    return if pages.empty?
    yield(pages)
  end
end
