class CreateUserIssueMonths < ActiveRecord::Migration
  def self.up
    create_table :user_issue_months do |t|
      t.column :uid, :integer
      t.column :issue, :integer
      t.column :month, :integer
      t.column :day, :integer
      t.column :hour, :integer
      t.column :comment, :string
    end
  end

  def self.down
    drop_table :user_issue_months
  end
end
