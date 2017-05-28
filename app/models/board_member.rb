class BoardMember < ApplicationRecord
  belongs_to  :user, :class_name => 'User', :foreign_key => 'member_id'
  belongs_to  :board

  has_many :lists
end
