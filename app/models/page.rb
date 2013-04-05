class Page < ActiveRecord::Base

  attr_accessible :content, :date, :stamp, :title, :paths_attributes



  has_many :paths, :foreign_key => :page_to_id, :dependent => :destroy
  has_many :reverse_paths , :class_name => :Path, :foreign_key => :page_from_id 
  
  has_many :pages, :through => :paths, :source => :page_from, :dependent => :destroy

  accepts_nested_attributes_for  :paths, :reverse_paths, :pages
end
