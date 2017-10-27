class ApplicationMailer < ActionMailer::Base


  default from: 'jamie.degnan@gmail.com'
  layout 'welcome_new_user'


  def welcome_new_user(resource)
     @user = resource
     mail(:to => @user.email, :subject => "Welcome to SafeWays!",
       template_path: 'layouts',
       template_name: 'welcome_new_user')
  end


end
