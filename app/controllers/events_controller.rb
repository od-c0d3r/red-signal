class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params

    Rails.logger.debug @event

    if @event.save
      respond_to do |format|
        format.html { redirect_to admin_dashboard_path, notice: 'Event was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.expect(event: [ :title, :longitude, :latitude, :briefing ])
  end
end
