class Page < ActiveRecord::Base
  default_scope :order => 'position ASC'  
  named_scope :top, :conditions => {:parent_id => nil}, :order => :position
  # http://ramblings.gibberishcode.net/archives/one-activerecord-model-acting-as-a-list-and-tree
  
  has_assets
  acts_as_content_node
  acts_as_tree
  acts_as_list :scope => :parent_id
  acts_as_textiled :body
  acts_as_taggable

  before_save :keep_position_sane

  validates_presence_of :title
  validates_presence_of :body, :tag_list, :description, :if => :publish
  
  def first_child?
    self == self.self_and_siblings.first
  end
  
  def last_child?
    self == self.self_and_siblings.last
  end

  def self.reindex_top_level_pages(recurse = true, departing_child = nil)
    reindex_pages(self.top, recurse, departing_child)
  end

  def reindex_children(recurse = true, departing_child = nil)
    Page.reindex_pages(children, recurse, departing_child)
  end
  
  def root?
    parent_id.nil?
  end
  
  def featured?
    !features.empty?
  end
  
  def lock_level
    read_attribute(:lock_level) || 0
  end

  private

  # takes a given array of pages and recursively (or not) reindexes
  # if departing_child is supplied, it is removed from the array so 
  # that former siblings are reindexed as though it was already 
  # removed from the collection.
  def self.reindex_pages(pages, recurse, departing_child)
    pages.select{|r| r != departing_child}.each_with_index do |page, index|
      page.reindex_children(true) if recurse
      page.update_attributes(:position => index + 1)
    end
    true
  end

  # When the parent id of a node changes, the acts_as_list gets lost, so 
  # we need to reindex the affected nodes to keep things sane
  def keep_position_sane
    return unless self.parent_id_changed?

    # reindex the group this page is being removed from
    if self.parent_id_was.nil? then
      Page.reindex_top_level_pages(false, self)
    else
      Page.find(self.parent_id_was).reindex_children(false, self)
    end

    # make this page the last sibling of the new parent group of pages
    last_page = (self.parent_id.nil? ? Page.top.last : Page.find(self.parent_id).children.last)
    self.position = (last_page.nil? ? 1 : last_page.position + 1)
    true
  end 
end