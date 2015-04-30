class User < ActiveRecord::Base
  # include RoleModel
  # attr_accessor :roles_mask
  attr_accessor :signin

  before_create :default_role

  # roles_attribute :roles_mask
  # roles :admin, :user, :guest
  # has_many :menus

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:signin]

  # validates :name, presence: true
  validates :username, :uniqueness => { case_sensitive: false}
  
  def self.find_first_by_auth_conditions warden_conditions
  	conditions = warden_conditions.dup
      if signin = conditions.delete(:signin)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", 
        	{ value: signin.downcase }]).first
      else
        where(conditions.to_h).first
    end
  end

  def has_role? role
    roles.to_sym == role
  end

  protected
    def default_role
      self.roles = :user
    end
end
