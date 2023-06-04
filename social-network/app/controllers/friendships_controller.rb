class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ show edit update destroy ]
  before_action :save_referer_url , only: %i[ destroy update ]

  # GET /friendships or /friendships.json
  def index
    @friendships = Friendship.where("user_id = ? OR friend_id = ?", current_user, current_user)
    @friends = Array.new
    @friendships.each do |friendship|
      if friendship.user == current_user
        @friends.push(friendship.friend)
      else
        @friends.push(friendship.user)
      end
    end
  end

  # GET /friendships/1 or /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships or /friendships.json
  def create
    friendship_request = FriendshipRequest.find(params[:friendship_request_id])
    if friendship_request
      @friendship = Friendship.new({:user => friendship_request.from_user, :friend => current_user})
      respond_to do |format|
        if @friendship.save
          friendship_request.destroy
          format.html { redirect_to referer_url, notice: "Friendship was successfully created." }
          format.json { render :show, status: :created, location: @friendship }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @friendship.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /friendships/1 or /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to referer_url, notice: "Friendship was successfully updated." }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to referer_url, notice: "Friendship was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def save_referer_url
      session[:redirect_back] ||= request.referer
    end

    def referer_url
      session[:redirect_back]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end
