class AddIsApprovedToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :is_approved, :boolean, default: false
  end
end
