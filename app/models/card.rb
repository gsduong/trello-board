class Card < ApplicationRecord
  # Define has_many CardMember
  has_many  :card_members, :class_name => 'CardMember', :foreign_key => 'card_id', dependent: :destroy
  has_many  :users, :through => :card_members

  # Define belongs_to List
  belongs_to  :list

  # Define has_many CardActivity
  has_many  :card_activities, :foreign_key => 'card_id', :class_name => 'CardActivity'

  # Define has_many CardComment
  has_many  :card_comments, :foreign_key => 'card_id', :class_name => 'CardComment'

  def belong_to?(user)
    !self.card_members.find_by(member_id: user.id).nil?
  end
end
