class Api::V1::MusicsController < ApplicationController
  before_action :check_login , only: %i[ index show  update  destory ]
  before_action :set_music , only: %i[ show update destory ]

 def index 
   @musics = Music.all
   render_success_response(data: { musics: @musics }, message: "success")
 end

 def create
   puts music_params
   @music = Music.new(music_params)

   if @music.save
     render_success_response( data: @music , message: "Music created successfully")
   else
     render_error_response( data: @music.errors, message: "errors")
   end
 end

 def show
   render_success_response(data: @music , message: "success")
 end


 def update
  if @music.update(music_params)
    render_success_response( data: @music , message: "Music updated successfully")
  else
    render_error_response( data: @music.errors , message: "errors")
  end
 end

 def destory
   @music.destory
   head 204
 end

 private 

 def set_music
   @music = Music.find(params[:id])
 end

 def music_params
   params.require(:music).permit(:title, :album_name, :genre, :singer_id)
 end

#  def singer_params
#    params.require(:singer).permit(:id)
#  end
end
