module PostsHelper
  def render_post_description(post)
    simple_format(post.description)
  end

  def render_job_status(job)
    if job.is_hidden
      content_tag(:span, "", :class => "fa fa-lock")
    else
      content_tag(:span, "", :class => "fa fa-globe")
    end
  end
end
