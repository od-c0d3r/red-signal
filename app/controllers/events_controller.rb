class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params

    if @event.save
      respond_to do |format|
        format.html { redirect_to admin_path, notice: "Event was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # TODO feature: searching nearby nested form for event

  # def searching_nearby
  #   @nearby_users = User.online.near([ nearby_params[0].to_f, nearby_params[1].to_f ], nearby_params[2].to_f)
  # end

  private

  def event_params
    params.expect(event: [ :title, :longitude, :latitude, :briefing ])
  end

  # def nearby_params
  #   params.expect(:lat, :lng, :distance)
  # end
end
