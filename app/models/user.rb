class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  before_create :create_first_group

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :profile
  # attr_accessible :title, :body

  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :pages, :through => :groups
  has_many :paths, :through => :pages

  has_many :owned_groups, :class_name => :Group, :foreign_key => :user_id

  validates_presence_of :name
  validates_uniqueness_of :email, :case_sensitive => false
  validates :profile, :length => {:maximum =>  3000} 

  
  validates :name, obscenity: true
  validates :profile, obscenity: true

  has_reputation :votes, source: {reputation: :votes, of: :groups}, aggregated_by: :sum
  
  def create_first_group
    @Group = Group.create(title: self.name + "'s group", description: "The default group for " + self.name)
    self.groups << @Group
  end

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def votes
    self.reputation_for(:votes)
  end
end
