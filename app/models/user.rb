class User < ActiveRecord::Base

  #===========================================================================#
  #===   STATUS
  #===========================================================================#
  class UserStatus
    attr_reader :id, :name

    def initialize(id, name)
      @id, @name  = id, name
    end
  end

  STATUS_NONE   = 0
  STATUS_USER   = 1
  STATUS_ADMIN  = 2

  STATUS_LIST = [
      UserStatus.new(STATUS_NONE,   I18n.t('.user.status.none')),
      UserStatus.new(STATUS_USER,   I18n.t('.user.status.user')),
      UserStatus.new(STATUS_ADMIN,  I18n.t('.user.status.admin')),
  ]

  #===========================================================================#
  #===   ASSOCIATIONS
  #===========================================================================#
  has_many  :orders

  #===========================================================================#
  #===   VALIDATIONS
  #===========================================================================#
  validates_presence_of :first_name, :last_name, :login, :password
  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  #===========================================================================#
  #===   CALLBACKS
  #===========================================================================#
  before_create :init_token, :init_salt

  #===========================================================================#
  #===   PUBLIC
  #===========================================================================#
  attr_readonly :name, :status_to_string

  def name
    [self.first_name, self.last_name].join(" ")
  end

  def status_to_string
    STATUS_LIST[self.status].name
  end

  def as_json(options={})
    super(:except => [:password, :salt, :created_at, :updated_at])
  end

  # Static method to verify if user can authenticate with login and password
  #
  # if succeed  => return *user*
  # else        => nil
  def self.authenticate(login, password)
    find_by_login_and_password(login, password)
  end

  #===========================================================================#
  #===   PROTECTED
  #===========================================================================#
  protected

  # Create *token* for new User
  def init_token
    self.token = SecureRandom.hex(64) if self.token.blank?
  end

  # Create *salt* for new User
  def init_salt
    self.salt = SecureRandom.hex(25) if self.salt.blank?
  end

end
