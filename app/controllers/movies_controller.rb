class MoviesController < ApplicationController

  def index
    if params[:error].present?
      @error = true
    end
    if params[:title].present?
      response = HTTParty.get("http://api.themoviedb.org/3/search/movie", body: api_credentials_hash.merge({query: params[:title]}))
    else
      response = HTTParty.post("http://api.themoviedb.org/3/movie/popular", body: api_credentials_hash)
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
    response = HTTParty.get("http://api.themoviedb.org/3/movie/#{id}", body: api_credentials_hash)
    if response.code != 200
      redirect_to controller: 'movies', action: 'index', error: true
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
    {api_key: "c5682edbb47129ba8c07d25e6d13db13"}
  end

end
