class Clearance::UsersController < ApplicationController
  # SOURCECODE FROM https://github.com/thoughtbot/clearance/blob/main/app/controllers/clearance/users_controller.rb

    def new
        @user = user_from_params
        render template: "users/new"
    end

    def create
        @user = user_from_params

        if @user.save
            sign_in @user
            profile = Profile.new
            profile.username = @user.email.to_s.split('@')[0]
            profile.imageurl = "default-image.jpg"
            profile.user = @user
            profile.onlyForFriends = false
            if profile.save
                redirect_back_or url_after_create
            else
                render template: "profiles/new"
            end
        else
            render template: "users/new"
        end
    end

    private

    def redirect_signed_in_users
        if signed_in?
          redirect_to Clearance.configuration.redirect_url
        end
    end

    def url_after_create
        Clearance.configuration.redirect_url
    end

    def user_from_params
        email = user_params.delete(:email)
        password = user_params.delete(:password)
    
        Clearance.configuration.user_model.new(user_params).tap do |user|
          user.email = email
          user.password = password
        end
      end
    
    def user_params
      params[Clearance.configuration.user_parameter] || Hash.new
    end
end