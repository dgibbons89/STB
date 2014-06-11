class MediaController < ApplicationController
  def index
  	@media = Picture.all
  	@media = @media < Video.all
  end
end
