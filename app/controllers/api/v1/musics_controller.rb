class Api::V1::MusicsController < ApplicationController
  before_action :check_login, only: %i[ index show update destroy ]
  before_action :set_music, only: %i[ show update destroy ]

  before_action only: %i[ update show destroy index ] do has_permission([ "super_admin", "artist_manager", "artist" ]) end


 include MusicConcern

 def index
   @musics = retrive_musics
    render_success_response(data: { musics: @musics }, meta: @musics, message: "success")
 end

 def create
   @music = Music.new(music_params)

   if @music.save
     render_success_response(data: @music, message: "Music created successfully")
   else
     render_error_response(data: @music.errors, message: "errors")
   end
 end

 def show
   render_success_response(data: @music, message: "success")
 end


 def update
  if @music.update(music_params)
    render_success_response(data: @music, message: "Music updated successfully")
  else
    render_error_response(data: @music.errors, message: "errors")
  end
 end

 def destroy
   @music.destroy
   render_success_response(message: "Successfully deleted")
 end

 private

 def set_music
  begin
    @music = Music.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    raise e
  end
 end

 def music_params
   params.require(:music).permit(:title, :album_name, :genre, :singer_id)
 end
end
