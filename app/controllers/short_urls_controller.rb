class ShortUrlsController < ApplicationController
  before_action :set_short_url, only: [:show, :edit, :update, :destroy]

  # GET /short_urls
  # GET /short_urls.json
  def index
    @short_urls = ShortUrl.all
  end

  # GET /short_urls/1
  # GET /short_urls/1.json
  def show
    #render text: @short_url.mini_url
  end

  # GET /short_urls/new
  def new
    @short_url = ShortUrl.new
  end

  # POST /short_urls
  # POST /short_urls.json
  def create
    @short_url = ShortUrl.new(short_url_params)

    respond_to do |format|
      if @short_url.save
        format.html { redirect_to @short_url, notice: 'Short url was successfully created.' }
        format.json { render :show, status: :created, location: @short_url }
      else
        format.html { render :new }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # get by id, if numeric, otherwise get by mini_url
    def set_short_url
      if params[:id] =~ /\d/
        @short_url = ShortUrl.find(params[:id])
      else
        @short_url = ShortUrl.url_for(params[:id])
      end
    end

    def short_url_params
      params.require(:short_url).permit(:url, :mini_url)
    end
end
