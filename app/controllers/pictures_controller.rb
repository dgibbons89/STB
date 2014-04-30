class PicturesController < ApplicationController

	def index #will have template
		@pictures = Picture.all
	end

	def show
	#will have template
		@picture = Picture.find(params[:id])
	end

	def new #display the form for new record
	#will have template
	@picture = Picture.new
	end

	def create #will save new record
		@picture = Picture.new(allowed_params)
		if @picture.save
			redirect_to pictures_path
		else
			render action:'new'
		end
	end


	def edit #display form for existing	
	#will have template
		@picture = Picture.find(params[:id])
	end

	def update #save update
	#will redirect
		@picture = Picture.find(params[:id])
		if @picture.update_attributes(allowed_params)
			redirect_to pictures_path
		else
			render 'new'
		end
	end

	def destroy
	#will redirect
		@picture = Picture.find(params[:id])
		@picture.destroy
		redirect_to pictures_path
	end

	private
		def allowed_params
			params.require(:picture).permit(:zip, :image, :content)
		end
	

end
