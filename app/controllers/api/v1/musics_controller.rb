class Api::V1::MusicsController < ApplicationController
  before_action :check_login , only: %i[ index show  update  destory ]
  before_action :set_music , only: %i[ show update destory ]

  include Pagination

 def index 
   @musics = Music.page(current_page).per(per_page)
   options = {
        links: {
        current: api_v1_musics_path(page: @musics.current_page),
        first: api_v1_musics_path(page: 1),
        last: api_v1_musics_path(page: @musics.total_pages),
        prev: api_v1_musics_path(page: @musics.prev_page),
        next: api_v1_musics_path(page: @musics.next_page),
        total_page: @musics.total_pages,
        total: @music.count
        }
    }
   render_success_response(data: { musics: @musics , **options }, message: "success")
 end

 def create
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
end
