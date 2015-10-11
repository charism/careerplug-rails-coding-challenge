module ApplicationHelper
  def root_path
    if user_signed_in? 
      authenticated_root_path
    else 
      unauthenticated_root_path
    end
  end 
  
  def main_header_links
    unless user_signed_in?
      {
        "Sign Up" => new_user_registration_path,
        "Login"   => new_user_session_path
      }
    else
      {
        "All Jobs"   => user_jobs_path(current_user.id),
        "Post a Job" => new_user_job_path(current_user.id)
      }
    end
  end
end
