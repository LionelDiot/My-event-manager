class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :owner?, only: [:destroy, :edit, :update]
  # GET /events or /events.json
  def index
    @events = Event.order(start_date: :asc).all
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        flash[:success] = "Ton evenement a bien été créé !"
        format.html { redirect_to event_url(@event) }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        flash[:success] = "Ton évenement a bien été modifié !"
        format.html { redirect_to event_url(@event)}
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      flash[:success] = "Ton profil a bien été supprimé !"
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :admin_id)
    end

    def owner?
      @event = Event.find(params[:id])
      unless current_user == @event.admin
        flash[:danger] = "Impossible vous n'êtes pas le propriétaire de l'evenement !"
        redirect_to "/"
      end
    end
end
