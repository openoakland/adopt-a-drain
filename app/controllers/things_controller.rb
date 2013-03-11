class ThingsController < ApplicationController
  respond_to :json

  def show
    @things = Thing.where("lat < ? AND lat > ? AND lng < ? AND lng > ? ", params[:NE][:lat], params[:SW][:lat], params[:NE][:lng], params[:SW][:lng])




    unless @things.blank?
      for t in @things
          if user_signed_in? && t.adopted_by(current_user.id) then
            t.owned_by_you = true
          else
            t.owned_by_you = false
          end
      end
      render(:json => @things.to_json(:methods => :owned_by_you, :include => :users))
    else
      render(:json => {"errors" => {"address" => [t("errors.not_found", :thing => t("defaults.thing"))]}}, :status => 404)
    end
  end

  def update
    @thing = Thing.find(params[:id])
    if params[:thing][:user_id] == ""
        @thing.users.delete(current_user)
    else
      if @thing.users.length == 0
        @thing.update_attributes({:name=>params[:thing][:name]})
      end
      if !@thing.adopted_by(params[:thing][:user_id])
        @thing.users << current_user
      end
    end
    render(:json => @thing.to_json(:include => :users), :status => 200)
  end
end
