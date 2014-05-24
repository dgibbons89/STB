class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]



  def index
    if params[:search]
      @videos = Video.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    else
      @videos = Video.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    end
  end
  
  def upvote
    @video = Video.find(params[:id])
    @video.votes.create
    redirect_to video_path, :notice => "You know this person!"
  end
 
  
  def show
  end

  def new
    @video = current_user.videos.build
  end

  def edit
  end

  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: 'video was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if  @video.update(video_params)
      redirect_to @video, notice: 'video was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @video.destroy
    redirect_to videos_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    def correct_user
      @video = current_user.videos.find_by(id: params[:id])
      redirect_to videos_path, notice: "Not authorized to edit this video" if @video.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:zip, :video)
    end
end
