class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  # POST /users/speedCount
  def checkSpeed
    User.find(params[:id]).update(speed: calcSpeed(params[:speedCount]).to_i)
    @user = User.find(params[:id])
    render json: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # 定数
    TAPE_LENGTH = 1
    CHECK_TIME = 1
    TIME_CONST = 3600.0 / 1000.0

    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :speed)
    end

    # 時速計算(小数点以下切り捨て)
    def calcSpeed(speedCount)
      return TAPE_LENGTH.to_f * TIME_CONST.to_f * speedCount.to_f / CHECK_TIME.to_f
    end
end









