module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end

#   def sign_in_check
#   unless logged_in?
#     flash[:danger] = "ログインする必要があります。"
#     redirect_to new_session_path
#   else
#     case action_name
#     when "show","edit","update","destroy"
#       case params[:controller]
#       when "users","sessions"
#         unless session[:user_id] == params[:id].to_i
#           flash[:danger] = "他人のデータを扱うことはできません"
#           redirect_to tasks_path
#         end
#       when "tasks"
#         unless current_user.tasks.find_by(id: params[:id])
#           flash[:danger] = "他人のデータを扱うことはできません"
#           redirect_to tasks_path
#         end
#       end
#     end
#   end
# end
#
#   def logged_in_user_can_not_log_in
#     redirect_back(fallback_location: tasks_path) if session[:user_id]
#   end

end
