class UserMailer < ApplicationMailer
    default from: 'companybestpeers@gmail.com'                             

    def welcome_email(user)
        @user =user
        mail(to: @user.email,subject: "Welcome to my WorkerApp")
    end

end
