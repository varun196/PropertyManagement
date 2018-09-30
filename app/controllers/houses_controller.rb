class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
  end

  # GET /houses/new
  def new
    session[:previous_url] = request.referer
    @previous_url = request.referer
    @house = House.new
    if !session[:is_admin].nil? && session[:is_admin] == true
      @admin = true
    else
      realtor = Realtor.find_by(users_id: session[:user_id])
      if realtor.companies_id != nil
        @company = Company.find(realtor.companies_id).name
      else
        redirect_to session[:previous_url], notice: "invalid company"
      end
    end
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = Realtor.find_by(users_id: session[:user_id]).house.new(house_params)
    respond_to do |format|
      if @house.save
=begin
todo: Add entries in realtor_huose table | OR | Create new schema for realtor_house.
        @listing_track = CreateRealtorsHouse.new
        @listing_track.realtors_id = Realtor.find_by(users_id: session[:user_id])
        @listing_track.houses_id = @house.id
        if @listing_track.save
=end
        format.html {redirect_to houses_path, notice: 'House was successfully created.'}
        format.json {render :show, status: :created, location: @house}
=begin
        else
          format.html {render :new}
          format.json {render json: @listing_track.errors, status: :unprocessable_entity}
        end
=end
      else
        format.html {render :new}
        format.json {render json: @house.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html {redirect_to @house, notice: 'House was successfully updated.'}
        format.json {render :show, status: :ok, location: @house}
      else
        format.html {render :edit}
        format.json {render json: @house.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html {redirect_to houses_url, notice: 'House was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def house_params
    params.require(:house).permit(:companies_id, :location, :area, :year_built, :style, :list_prize, :floor_count, :basement, :owner_name)
  end
end
