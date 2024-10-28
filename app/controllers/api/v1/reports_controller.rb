class Api::V1::ReportsController < ApplicationController
  before_action :check_login, only: %i[ index ]
  before_action only: %i[ index ] do has_permission([ "super_admin", "artist_manager" ]) end

  def index
      @data =  Music.group(:genre).count
      # map the data
      @map_data = @data.map do |key, value|
        { title: key.to_s, count: value }
      end
      render_success_response(data: @map_data)
  end
end
