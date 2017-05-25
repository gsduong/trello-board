class User < ApplicationRecord
  # Define has_many Board through joint table board_members
  has_many  :board_members, :foreign_key => 'member_id', :class_name => 'BoardMember'
  has_many  :boards, :through => :board_members

  # Define has_many CardMember
  has_many  :card_members, :class_name => 'CardMember', :foreign_key => 'member_id'
  has_many  :cards, :through => :card_members

  validates_uniqueness_of :email
  validates_presence_of :email, :password_digest
  validates_length_of :password, { :minimum => 3 }
  def password
    @password || self.password_digest
  end

  def password=(password)
    @password = password_digest
    self.password_digest = BCrypt::Password.create(password)
  end

  def correct_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def reset_session_key
    new_key = SecureRandom.urlsafe_base64(32)
    while User.find_by_session_key(new_key)
      new_key = SecureRandom.urlsafe_base64(32)
    end
    self.session_key = new_key
    save
  end

  def destroy_session_key
    self.session_key = nil
    save
  end

  def correct_session_key?(key)
    key == self.session_key
  end
end
