class Page < ActiveRecord::Base

  attr_accessible :content, :stamp, :title, :paths_attributes



  has_many :reverse_paths, :class_name => :Path, :foreign_key => :page_from_id, :dependent => :destroy
  has_many :paths ,  :foreign_key => :page_to_id, :dependent => :destroy
  
  has_many :pages, :through => :reverse_paths, :source => :page_to
  has_many :reverse_pages, :through => :paths, :source => :page_from

  accepts_nested_attributes_for  :paths, :reverse_paths, :pages, :reverse_pages
end
