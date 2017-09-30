class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings=Movie.ratings

    if(params[:ratings].present?)
    
          session[:ratings] = params[:ratings]
          if (session[:sort_by].present? and (not params[:sort_by].present?) )
          
                @movies = Movie.where("rating in (?)", params[:ratings].keys).order(session[:sort_by])
          else 
            
                @movies = Movie.where("rating in (?)", params[:ratings].keys).order(params[:sort_by])
                
                session[:sort_by] = params[:sort_by]
                
          end
          
    elsif(session[:ratings].present?)
        
          if (session[:sort_by].present? and (not params[:sort_by].present?) )
          
                @movies = Movie.where("rating in (?)", session[:ratings].keys).order(session[:sort_by])
          else
            
                @movies = Movie.where("rating in (?)", session[:ratings].keys).order(params[:sort_by])
                
                session[:sort_by] = params[:sort_by]
                
          end
          
    elsif
            @movies = Movie.order(params[:sort_by])

    end
    
    if params[:sort_by] == 'title' 
    
            @title_header= 'hilite'
            
    elsif params[:sort_by] == 'release_date'
    
            @release_header ='hilite'
            
    elsif session[:sort_by] == 'title'
    
            @title_header ='hilite'
            
    elsif session[:sort_by] == 'release_date'
    
            @release_header ='hilite'
       
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  
  
  
end
