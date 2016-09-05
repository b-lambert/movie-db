class MoviesController < ApplicationController

  def index
    # TODO cleanup
    @titles = HTTParty.post("http://api.themoviedb.org/3/movie/popular", body: {api_key: "c5682edbb47129ba8c07d25e6d13db13"})["results"].each_with_object([]) do |result, titles_list|
      titles_list << result["title"]
    end
  end

  def show
    title = params[:title]
    # handleClick: function(){
    #       console.log("click detected");
    #       $.get("http://api.themoviedb.org/3/search/movie", {api_key: "c5682edbb47129ba8c07d25e6d13db13", query: "Nemo"}, function(data){
    #
    #       }).done(function(data){
    #         var jsonData = data;
    #         var results = jsonData["results"];
    #         movies_array = [];
    #         $.each(results, function(i, result){
    #           movies_array.push(result["title"]);
    #         });
    #         ReactDOM.render(<MovieList list={movies_array} />, document.getElementById('container'));
    #       });
    #     }
    #   });
    HTTParty.get("http://api.themoviedb.org/3/search/movie", {api_key: "c5682edbb47129ba8c07d25e6d13db13", query: title})["results"].each do |result|
      
    end
  end

end
