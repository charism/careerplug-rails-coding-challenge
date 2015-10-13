class AddCommentsToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :comment, :text
  end
end
