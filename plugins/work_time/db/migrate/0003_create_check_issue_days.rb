class CreateCheckIssueDays < ActiveRecord::Migration
  def self.up
    create_table :check_issue_days do |t|
      t.column :uid, :integer
      t.column :month, :integer
      t.column :day, :integer
      t.column :year, :integer
      t.column :check, :boolean
    end
  end

  def self.down
    drop_table :check_issue_days
  end
end
