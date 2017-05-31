class List < ApplicationRecord
  # Define belongs_to Board
  belongs_to  :board

  # Define has_many Card
  has_many  :cards, dependent: :destroy
end
