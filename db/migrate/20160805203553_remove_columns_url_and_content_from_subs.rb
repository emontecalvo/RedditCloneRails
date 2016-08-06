class RemoveColumnsUrlAndContentFromSubs < ActiveRecord::Migration
  def change
    remove_column :subs, :content
    remove_column :subs, :url
  end
end
