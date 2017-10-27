class ApplicationMailer < ActionMailer::Base


  default from: 'name@example.com'
  layout 'welcome_new_user'


  def welcome_new_user(resource)
     @user = resource
     ## FIXME: update brand name
     mail(:to => @user.email, :subject => "Welcome to SafeWays!",
       template_path: 'layouts',
       template_name: 'welcome_new_user')
  end


end
