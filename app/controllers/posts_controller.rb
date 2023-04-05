class PostsController < ApplicationController
    before_action :authorize_request
    before_action :find_post, except: %i[create index]
    include JsonResponse
  
    # GET /users
    def index
      posts = Post.all
      render json: posts, each_serializer: PostSerializer, status: :ok
    end
  
    # GET /users/{username}
    def show
      render json: @post, status: :ok
    end
  
    # POST /users
    def create
      @post = @current_user.posts.new(post_params)
      if @post.save
        render json: @post, status: :created
      else
        unprocessable_entity_response(@post)
      end
    end
  
    # PUT /users/{username}
    def update
      unless @post.update(post_params)
        unprocessable_entity_response(@post)
      end
      render json: @post
    end
  
    # DELETE /users/{username}
    def destroy
      @post.destroy
    end
  
    private
  
    def find_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
       render json: { errors: 'Post not found' }, status: :not_found
    end
  
    def post_params
      params.permit(
        :title, :description,  images: []
      )
    end
  
end
