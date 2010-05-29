# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def gravatar(email)
    gravatar_email = Digest::MD5.hexdigest(email)
    image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{gravatar_email}", :class => 'avatar'
  end
  
  def external_url(path)
    if Rails.env == 'development'
      "#{request.protocol}#{request.host_with_port}#{path}"
    else
      "#{request.protocol}#{request.host}#{path}"
    end
  end
end
