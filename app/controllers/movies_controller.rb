class MoviesController < ApplicationController

  def index
    if params[:title].present?
      response = HTTParty.get("#{root_api_url}/search/movie", body: api_credentials_hash.merge({query: params[:title]}))
    else
      response = HTTParty.post("#{root_api_url}/movie/popular", body: api_credentials_hash)
    end
    if response.code == 200
      @movies = response["results"].each_with_object([]) do |result, movie_list|
        movie_list << {title: result["title"], id: result["id"]}
      end
    else
      @api_error = true
    end
  end

  def show
    id = params[:id]
    response = HTTParty.get("#{root_api_url}/movie/#{id}", body: api_credentials_hash)
    if response.code != 200
      redirect_to movies_path, flash: { error: "true" }
    else
      @title = response["title"]
      @genres = response["genres"].map{|x| x["name"]}.join(", ")
      @overview = response["overview"]
      @production_companies = response["production_companies"].map{|x| x["name"]}.join(", ")
      @release_date = response["release_date"]
      @revenue = response["revenue"]
      @tagline = response["tagline"]
      @poster_path = response["poster_path"]
    end
  end

  private
  def api_credentials_hash
    # Note: For serious environments this would go in a file not stored in revision control
    {api_key: "c5682edbb47129ba8c07d25e6d13db13"}
  end

  def root_api_url
    "http://api.themoviedb.org/3"
  end

end
