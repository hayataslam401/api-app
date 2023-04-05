class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]
  include JsonResponse
  # GET /users
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user,serializer: UserSerializer, status: :ok
  end


  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      unprocessable_entity_response(@user)
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      unprocessable_entity_response(@user)
    end
    render json: @user
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
  rescue ActiveRecord::RecordNotFound
     render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password
    )
  end
end
