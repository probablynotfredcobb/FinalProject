class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
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
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
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

  def self.twilio
    new.twilio(message)
    redirect_to root_url,
      success: 'Thank you! The poster should be contacting you shortly.'
  rescue Twilio::REST::RequestError => error
    p error.message
    redirect_to root_url,
      error: 'Oops! There was an error. Please try again.'
  end

  def twilio
    @client.account.messages.create(
      from:  twilio_number,
      to:    agent_number,
      body:  message
    )
  end

  def initialize
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :picture, :location, :tag, :price, :user_id, :phone_number)
    end

    def message
      # byebug
      "Hey! Looks like someone is interested in  #{params[:hidden_title]}. " \
      "You can contact them back at:  #{params[:phone_number]}. " \
      "Message: #{params[:message]}"
    end

    def twilio_number
      # A Twilio number you control - choose one from:
      # https://www.twilio.com/user/account/phone-numbers/incoming
      # Specify in E.164 format, e.g. "+16519998877"
      twilio_number = ENV['TWILIO_NUMBER']
    end

    def agent_number
      # The sales rep / agent's phone number
      set_post
      agent_number =  @post.phone_number #ENV['AGENT_NUMBER']
    end
end
