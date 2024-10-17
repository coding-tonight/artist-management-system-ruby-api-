class Api::V1::SingersController < ApplicationController
  before_action :check_login , only: %i[index create show update destory ]
  before_action :set_singer , only: %i[ update show destory ]

  include Pagination

  def index
    @singers = Singer.order(:name).page params[:page]
    
    options = {
        links: {
        current: api_v1_singers_path(page: @singers.current_page),
        first: api_v1_singers_path(page: 1),
        last: api_v1_singers_path(page: @singers.total_pages),
        prev: api_v1_singers_path(page: @singers.prev_page),
        next: api_v1_singers_path(page: @singers.next_page),
        total_page: @singers.total_pages,
        total: @singers.count
        }
    }
    render_success_response(data: { singers: @singers , **options }, message: 'Singer created successfully')
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
       render_success_response(data: @singer, message: 'Singer updated successfully')
    else
      render_error_response(@singer.errors, message: 'errors')
    end
  end


  def destory
    @singer.destory
    head 204
  end

  private 
  
  def set_singer
    @singer = Singer.find(params[:id])
  end

  def singer_params
    params.require(:singer).permit(:name, :dob, :gender, :first_release_year, :no_of_albums_released)
  end
end
