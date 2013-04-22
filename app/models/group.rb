class Group < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :pages

  has_many :memberships
  has_many :users, :through => :memberships

  belongs_to :user

  validates :title, obscenity: true
  validates :description,  obscenity: { sanitize: true, replacement: :default}

  has_reputation :votes, source: {reputation: :votes, of: :pages}, aggregated_by: :sum, source_of: [{:reputation => :votes, :of => :user}]

  def votes
    self.reputation_for(:votes)
  end
end
