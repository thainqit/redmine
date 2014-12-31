require 'redmine'
require_dependency 'redmine_jchat/hooks'
Redmine::Plugin.register :redmine_jchat do
  name 'Redmine Chat'
  author 'Quang Thai'
  description 'This is a plugin for Redmine team chat.'
  version '0.0.1'
  settings(:partial => 'settings/chat')
end
