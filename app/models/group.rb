class Group < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :pages

  has_many :memberships
  has_many :users, :through => :memberships

  belongs_to :user

  has_reputation :votes, source: {reputation: :votes, of: :pages}, aggregated_by: :sum
end
