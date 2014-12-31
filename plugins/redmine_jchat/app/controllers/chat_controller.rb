class ChatController < ApplicationController
  unloadable
  def index
    # @chats = Chat.find_by_sql(["SELECT chats.*, u.firstName, u.lastName FROM chats INNER JOIN users u on chats.user = u.id  ORDER BY created_at DESC" ])
    @chats = Chat.where(project: params[:project].to_i)
    respond_to do |format|
      format.js {
        @return_content = render_to_string(:partial => "/chat/show_chat", :locals => {:chats => @chats})
      }
    end
  end

  def receive_chat
    @user = User.current
    @chats = Chat.find_by_sql(["SELECT chats.*, u.firstName, u.lastName FROM chats INNER JOIN users u on chats.user = u.id  ORDER BY created_at DESC LIMIT 15" ])
    render :partial => 'chat/receive_chat.erb'
  end

  def create
    @chat = Chat.create(message: params[:message], user: User.current.id, project: params[:project].to_i )
    @chats = Chat.where(project: params[:project].to_i)
    respond_to do |format|
      format.js {
        @return_content = render_to_string(:partial => "/chat/show_chat", :locals => {:chats => @chats})
      }
    end
  end

  def show_user
    @users = User.active.joins(:members).where("#{Member.table_name}.project_id = ?", params[:project].to_i)
    respond_to do |format|
      format.js {
        @return_content = render_to_string(:partial => "/chat/show_user", :locals => {:users => @users})
      }
    end
  end

  def set_members
    @members = []
    @hierarchy_projects.each do |project|
      project.assignable_users.each do |user|
        @members.push(user) unless @members.include?(user)
      end
    end
  end

end
