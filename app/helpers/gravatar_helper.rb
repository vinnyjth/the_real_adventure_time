module GravatarHelper
 def user_avatar_image_url(user)
   if user.user_image_url.present?
    user.user_image_url
   else
   # sets our custom image path
    default_image = "#{root_url}images/users/default_image.png"
 
    # pass in the user's email through Digest::MD5.hexdigest downcase
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
 
    #returns the url for the gravatar image or our custom image if no gravatar
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_image)}"
   end
 end
end