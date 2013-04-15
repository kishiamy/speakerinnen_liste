class OmniauthCallbacksController < ApplicationController
  def all
    profile = Profile.from_omniauth(request.env["omniauth.auth"])
    if profile.persisted?
      sign_in_and_redirect profile, notice: "Signed in!"
    else
      session["devise.profile_attributes"] = profile.attributes
      redirect_to new_profile_registration_url
    end
  end
  alias_method :twitter, :all
end
