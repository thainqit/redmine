class AddColumnYearToUserIssueMonths < ActiveRecord::Migration
  def change
    add_column :user_issue_months, :year, :integer
  end
end
