class Api::V1::SingersController < ApplicationController
  before_action :check_login, only: %i[ index create show update destroy ]
  before_action :set_singer, only: %i[ update show destroy ]

  before_action only: %i[ update show destroy index ] do has_permission([ "super_admin", "artist_manager" ]) end

  include SingerConcern

  def index
    @singers = retrive_singers()
    render_success_response(data: { singers: @singers }, meta: @singers, message: "Singer created successfully")
  end

  def create
    @singer = Singer.new(singer_params)

    if @singer.save
      render_success_response(data: @singer, message: "success")
    else
      render_error_response(@singer.errors, message: "errors")
    end
  end

  def show
    render_success_response(data: @singer, message: "success")
  end

  def update
    if @singer.update(singer_params)
       render_success_response(data: @singer, message: "Singer updated successfully")
    else
      render_error_response(@singer.errors, message: "errors")
    end
  end

  def destroy
    @singer.destroy
    render_success_response(message: "Successfully deleted")
  end

  def singermusics
    @musics = retrive_singer_musics.page(current_page).per(per_page)
    render_success_response(data: @musics, message: "success")
  end

  def import
    # import data form the csv
    Singer.import(params[:file])
    render_success_response(message: "Successfully imported csv data")
  end

  def export
    @file = Singer.to_csv
    send_data @file, fileName: "singers.csv", type: "text/csv; charset=iso-8859-1; header=present"
  end

  def list
    # singers list without pagination
    @singers = Singer.select(
      :id, :name
      )
    render_success_response(data: { singers: @singers }, message: "Singer created successfully")
  end

  private

  def set_singer
    @singer = Singer.find(params[:id])
  end

  def singer_params
    params.require(:singer).permit(:name, :dob, :gender, :first_release_year, :no_of_albums_released, :address)
  end
end
