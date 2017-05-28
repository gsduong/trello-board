class User < ApplicationRecord
  attr_accessor :remember_token # this field is virtual, not in db
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6}
  has_secure_password

  # Define has_many Board through joint table board_members
  has_many  :board_members, :foreign_key => 'member_id', :class_name => 'BoardMember'
  has_many  :boards, :through => :board_members

  # Define has_many CardMember
  has_many  :card_members, :class_name => 'CardMember', :foreign_key => 'member_id'
  has_many  :cards, :through => :card_members


  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token) # remember_token here is a local var to this method
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end
