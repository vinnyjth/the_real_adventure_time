class Group < ActiveRecord::Base
  attr_accessible :description, :title
  has_many :pages

  has_many :memberships
  has_many :users, :through => :memberships
end
