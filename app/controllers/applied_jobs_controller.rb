class AppliedJobsController < ApplicationController

  def apply
    post = Post.find(params[:id])
    if AppliedJob.where("post_id = ? AND user_id = ?", params[:id], current_user.id).exists?
      redirect_to posts_path(post), notice: 'You have already applied for this job!'
    else
      AppliedJob.create(user_id: current_user.id, post_id: params[:id], status: "pending")
      user=User.find(current_user.id)
      PostMailer.thank_apply(user).deliver_now
      redirect_to posts_path(post), notice: 'You have applied for this job successfully!'
    end
  end

  def selected
    post = Post.find(params[:id])
    vacancy_limit = post.vacancy
    selected_user_count = AppliedJob.where("post_id = ? AND user_id = ? AND status = ?", params[:id], params[:user_id],"selected").count

    if selected_user_count >= vacancy_limit
      redirect_to posts_path, notice: "Vacancy limit reached. You cannot select more candidates"
    elsif AppliedJob.where("post_id = ? AND user_id = ? AND status = ?", params[:id], params[:user_id],"selected").exists?
      redirect_to posts_path(post), notice: 'You have already selected this profile!'
    else
      AppliedJob.where("post_id = ? AND user_id = ?", params[:id], params[:user_id]).update(status: "selected")
        user=User.find(params[:user_id])
        PostMailer.congrats_selection(user).deliver_now
        post.update(vacancy: post.vacancy - 1)
        redirect_to posts_path(post), notice: 'You have selected this profile successfully!'
    end
  end 

  def reject
    post = Post.find(params[:id])
    apply_job = AppliedJob.where("post_id = ? AND user_id = ?", params[:id], params[:user_id])
  
    if apply_job.exists?
      status = apply_job.first.status
  
      if status == 'rejected'
        redirect_to posts_path(post), notice: 'You have already rejected this profile!'
      elsif status == 'pending'
        user=User.find(params[:user_id])
        PostMailer.reject(user).deliver_now
        apply_job.first.update(status: 'rejected')
        redirect_to posts_path(post), notice: 'You have rejected this profile successfully!!'
      else
        user=User.find(params[:user_id])
        PostMailer.reject(user).deliver_now
        apply_job.first.update(status: 'rejected')
        post.update(vacancy: post.vacancy + 1)
        redirect_to posts_path(post), notice: 'You have rejected this profile successfully!'
      end
      
    end
  end  

  def show_applies
      if current_user.role == "contractor"
        @applied_jobs =  AppliedJob.joins(:post).where(posts: {user_id: current_user.id}) 
        @applications = @applied_jobs.where("post_id = ?", params[:id])
        if @applications.empty?
          redirect_to posts_path, notice: 'There are no job applications on this job post yet!'
        end
      else
        @applied_jobs = AppliedJob.where("user_id = ?",current_user.id)
        if @applied_jobs.empty?
          redirect_to root_path, notice: 'You have not applied for any job_post yet!'
        end
      end
  end

end
