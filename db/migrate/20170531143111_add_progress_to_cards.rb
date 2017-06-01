class AddProgressToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :progress, :integer, :default => 0
  end
end
