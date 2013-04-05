class Path < ActiveRecord::Base
  attr_accessible :page_from_id, :page_to_id, :question



  belongs_to :page_to, :class_name => "Page"
  belongs_to :page_from, :class_name => "Page"
end
