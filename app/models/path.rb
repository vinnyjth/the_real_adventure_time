class Path < ActiveRecord::Base
  attr_accessible :page_from_id, :page_to_id, :question


  validates :question, obscenity: true
  validates :question, presence: true
  
  belongs_to :page_to, :class_name => "Page"
  belongs_to :page_from, :class_name => "Page"

  belongs_to :user
end
