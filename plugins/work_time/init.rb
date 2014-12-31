Redmine::Plugin.register :work_time do
  name 'Work Time plugin'
  author 'Quang Thai'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  menu :account_menu, :work_time,
    {:controller => 'work_time', :action => 'index'}, :caption => :work_time
  menu :project_menu, :work_time,
    {:controller => 'work_time', :action => 'show'}, :caption => :work_time

end