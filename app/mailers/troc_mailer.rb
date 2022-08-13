class TrocMailer < ApplicationMailer
  default from: "soeurmarie1@gmail.com"
  def troc(user, content,email,title)
    @title=title
    @user=user
    @content=content
    @email=email
    mail(to: "soeurmarie1@gmail.com", subject: "il y a du troc sur cmdt guyane !")
  
  end
end
