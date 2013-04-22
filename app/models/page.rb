class Page < ActiveRecord::Base

  attr_accessible :content, :stamp, :title, :paths_attributes, :group_id, :color


  has_many :reverse_paths, :class_name => :Path, :foreign_key => :page_from_id, :dependent => :destroy
  has_many :paths ,  :foreign_key => :page_to_id, :dependent => :destroy
  
  has_many :pages, :through => :reverse_paths, :source => :page_to
  has_many :reverse_pages, :through => :paths, :source => :page_from

  belongs_to :group
  belongs_to :user

  accepts_nested_attributes_for  :paths, :reverse_paths, :pages, :reverse_pages

  validates :group_id, :presence => true
  validates :content, :presence => true
  validates :title, :presence => true

  has_reputation :votes, source: :user, aggregated_by: :sum, source_of: [{:reputation => :votes, :of => :group}]

  validates :title, obscenity: true
  validates :stamp, obscenity: true
  validates :content,  obscenity: { sanitize: true, replacement: :default}
  
  def self.search(search)
    if search
      where('title ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def votes
    self.reputation_for(:votes)
  end
end
