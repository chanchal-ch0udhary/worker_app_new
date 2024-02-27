class PostMailer < ApplicationMailer
    default from: 'companybestpeers@gmail.com'                             

    def thank_apply(user)
        @user =user
        mail(to: @user.email,subject: "Thanks for applying for the job!")
    end

    def congrats_selection(user)
        @user =user
        mail(to: @user.email,subject: "Congratulations on your selection!")
    end

    def reject(user)
        @user =user
        mail(to: @user.email,subject: "Application on your profile!")
    end
end
