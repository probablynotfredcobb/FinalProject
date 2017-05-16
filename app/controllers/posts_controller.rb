class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :latlng, only: [:create, :update]

  # GET /posts
  # GET /posts.json
  def index
    @page = params[:page].to_i || 1
    skip = (@page) * 9
    @posts = Post.all.order(created_at: :desc).limit(9).offset(skip)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Alright! Your post was successfully created!' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def post_params
  params.require(:post).permit(:title, :content, :image)
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def twilio
    TwilioApi.send(
      from:  twilio_number,
      to:    agent_number,
      body:  message
    )
    redirect_to posts_path, notice: 'Thanks for your message! The poster will be in contact with you shortly!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def latlng
      address = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{@post.location}&key=#{ENV.fetch('MAP_KEY')}").parsed_response
      @post.lat = address["results"][0]["geometry"]["location"]["lat"]
      @post.lng = address["results"][0]["geometry"]["location"]["lng"]
      @post.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :image, :location, :tag, :price, :user_id, :phone_number)
    end

    def message
      # byebug
      "Hey! Looks like someone is interested in  #{params[:hidden_title]}. " \
      "You can contact them back at:  #{params[:phone_number]}. " \
      "Message: #{params[:message]}"
    end


    def agent_number
      # The sales rep / agent's phone number
      set_post
      agent_number =  @post.phone_number #ENV['AGENT_NUMBER']
    end
end
