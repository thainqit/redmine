require 'date'
class WorkTimeController < ApplicationController
  unloadable

  def index
    @link_params = {:controller=>"work_time",
                  :year=>Time.now.year, :month=>Time.now.month, :day=>Time.now.day, :user=>User.current.id }
    @link_params.merge!(:action=>"show")
    
    redirect_to @link_params
  end

  def show
    @projects = User.current.projects
    
    @issues = Issue.all
    @days_in_month =  days_in_month(params[:year].to_i , params[:month].to_i)

    @days = []
    (1..@days_in_month).to_a.each do |x|
      time =params[:year].to_s + "-" + params[:month].to_s + "-" + x.to_s
      day_in_week = time.to_time.wday
      @days << day_in_week
    end

    @array_issue= []

    Issue.where( :assigned_to_id => params[:user].to_i).each do |issue|

      hour = 0
      UserIssueMonth.where(:issue => issue.id).each do |issues_month|
        hour = hour + issues_month.hour
      end
      if issue.estimated_hours > hour
        color = "#ccc"
      else
        color = "red"
      end
      @array_issue << "['##{issue.id.to_s}', #{issue.estimated_hours.to_s}, #{hour.to_s}, '#{color}' ] ,"
    end
  end

  def create_user_issue
    Rails.logger.info "#{params[:current_id]}"  
    Rails.logger.info "#{params[:issues_month]}"
    params[:issues_month].each do |key, value| 
      Rails.logger.info "#{key}"
      Rails.logger.info "#{value}"

        @issues_month = UserIssueMonth.where(:issue => key, :year => value[:year], :month => value[:month], :day => value[:day] ).first

        if @issues_month.present?
          @issues_month.uid = params[:current_id]
          @issues_month.issue = key
          @issues_month.year = value[:year]
          @issues_month.month = value[:month]
          @issues_month.day = value[:day]
          @issues_month.hour = value[:hour]
          @issues_month.comment = value[:comment] 

          @issues_month.save if value[:hour] != ""
        else 
          @issues_month = UserIssueMonth.new

          @issues_month.uid = params[:current_id]
          @issues_month.issue = key
          @issues_month.year = value[:year]
          @issues_month.month = value[:month]
          @issues_month.day = value[:day]
          @issues_month.hour = value[:hour]
          @issues_month.comment = value[:comment] 

          @issues_month.save if value[:hour] != ""
        end
    end
    @link_params = {:controller=>"work_time",
                  :year=> params[:year], :month=> params[:month], :day=> params[:day], :user=> params[:current_id]}
    @link_params.merge!(:action=>"show")
    
    redirect_to @link_params
    flash[:notice] = "cap nhat thanh cong"
  end

  def check_day
    Rails.logger.info "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

    @check_day = CheckIssueDay.where(:uid => params[:user], :day => params[:day], :month => params[:month], :year => params[:year])
    if @check_day.present?
      @check_day.update_attributes(:check => params[:check])
    else
      @check_day = CheckIssueDay.new(:uid => params[:user], :day => params[:day], :month => params[:month], :year => params[:year], :check => params[:check])
      @check_day.save
    end

  end

end

def days_in_month(year, month)
  (Date.new(year, 12, 31) << (12-month)).day
end