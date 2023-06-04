class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, only: %i[ show edit update destroy ]
  before_action :save_referer_url , only: %i[ destroy update ]

  # GET /friendship_requests or /friendship_requests.json
  def index
    @friendship_requests = FriendshipRequest.where("to_user_id = ?", current_user)
  end

  # GET /friendship_requests/1 or /friendship_requests/1.json
  def show
  end

  # GET /friendship_requests/new
  def new
    @friendship_request = FriendshipRequest.new
  end

  # GET /friendship_requests/1/edit
  def edit
  end

  # POST /friendship_requests or /friendship_requests.json
  def create
    user = User.find_by(params[:user_id])
    
    if user
      @friendship_request = FriendshipRequest.new()
      @friendship_request.to_user = user
      @friendship_request.from_user = current_user
      respond_to do |format|
        if @friendship_request.save
          format.html { redirect_to referer_url, notice: "Friendship request was successfully created." }
          format.json { render :show, status: :created, location: @friendship_request }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @friendship_request.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /friendship_requests/1 or /friendship_requests/1.json
  def update
    respond_to do |format|
      if @friendship_request.update(friendship_request_params)
        format.html { redirect_to friendship_request_url(@friendship_request), notice: "Friendship request was successfully updated." }
        format.json { render :show, status: :ok, location: @friendship_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friendship_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendship_requests/1 or /friendship_requests/1.json
  def destroy
    @friendship_request.destroy

    respond_to do |format|
      format.html { redirect_to referer_url, notice: "Friendship request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship_request
      @friendship_request = FriendshipRequest.find(params[:id])
    end

    def save_referer_url
      session[:redirect_back] ||= request.referer
    end

    def referer_url
      session[:redirect_back]
    end
    # Only allow a list of trusted parameters through.
    def friendship_request_params
      params.require(:friendship_request).permit(:from_user_id, :to_user_id)
    end
end
