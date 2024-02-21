class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def comment
    @the_comment = Comment.new
    
    @the_comment.venue_id = params.fetch("query_venue_id")
    @the_comment.author_id = params.fetch("query_author_id")
    @the_comment.body = params.fetch("query_body")
    @the_comment.save

    
    redirect_to("/venues/#{@the_comment.venue_id}")
  end

  def create
    @venues = Venue.new

    @venues.address = params.fetch("query_address")
    @venues.name = params.fetch("query_name")
    @venues.neighborhood = params.fetch("query_neighborhood")

    @venues.save


    redirect_to("/venues/#{@venues.id}")
  end
  
  #2/15 QUESTION: does the variable I define in method "update" have to match the endpoint HTML it's redirecting to so that the values get redefined dynamically.
  def update
    the_id = params.fetch("venue_id")

    @the_venue = Venue.where({ :id => the_id }).at(0)

    @the_venue.address = params.fetch("query_address")
    @the_venue.name = params.fetch("query_name")
    @the_venue.neighborhood = params.fetch("query_neighborhood")
    @the_venue.save
    
    redirect_to("/venues/#{@the_venue.id}")
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
