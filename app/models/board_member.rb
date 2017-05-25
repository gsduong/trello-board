class BoardMember < ApplicationRecord
  belongs_to  :user, :class_name => 'User'
  belongs_to  :board

  has_many :lists
end
