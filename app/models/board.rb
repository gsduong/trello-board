class Board < ApplicationRecord

  scope :by_ids, -> (ids) {where(id: ids)}

  # Define has_many User through board_members
  has_many  :board_members, :class_name => 'BoardMember', dependent: :destroy
  has_many  :users, :through => :board_members

  # Define has_many List
  has_many  :lists, dependent: :destroy

  # Define has_many BoardActivity
  has_many  :board_activities

  validates :name, :presence => true

end