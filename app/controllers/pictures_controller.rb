class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @pictures = Picture.search(params[:search]).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    else
      @pictures = Picture.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
    end
  end
  

  def search
    @pictures = Picture.search(params)
  end
  
  def show
  end

  def new
    @picture = current_user.pictures.build
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to @picture, notice: 'Picture was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if  @picture.update(picture_params)
      redirect_to @picture, notice: 'Picture was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def correct_user
      @picture = current_user.pictures.find_by(id: params[:id])
      redirect_to pictures_path, notice: "Not authorized to edit this picture" if @picture.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:zip, :image)
    end
end
