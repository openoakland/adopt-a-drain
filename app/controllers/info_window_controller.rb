class InfoWindowController < ApplicationController
  def index
    @thing = Thing.find_by_id(params[:thing_id])
    if @thing.adopted?
      if user_signed_in? && @thing.adopted_by(current_user.id)
        render("users/thank_you", :locals => {:thing => @thing})
      else
        render("users/profile")
      end
    else
      if user_signed_in?
        render("things/adopt")
      else
        render("users/sign_in")
      end
    end
  end
end
