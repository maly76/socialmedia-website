class ProfilesController < ApplicationController
  before_action :get_user
  before_action :set_profile, only: %i[ show edit update destroy ]

  # GET /profiles or /profiles.json
  def index
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = @user.profile
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to redirect_after_change, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to redirect_after_change, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to redirect_after_change, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def get_user
      @user = User.find(params[:user_id]) 
    end

    def redirect_after_change
      "/"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = @user.profile
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:user_id, :username, :fullname, :phone_number, :country, :street, :city, :birthday, :onlyForFriends, :imageurl)
    end
end
