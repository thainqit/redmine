class AddColumnProjectToChats < ActiveRecord::Migration
  def change
    add_column :chats, :project, :integer
  end
end
