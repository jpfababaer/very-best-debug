# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates(:username, {
    :presence => true,
    :uniqueness => { :case_sensitive => false },
  })

  #Store User Instance id into my_id
  #Uses my_id to query Comment database for "author_id" value.
  #Returns an ARR of Comment Instances from the User
  def comments
    my_id = self.id
    matching_comments = Comment.where({ :author_id => my_id })
    return matching_comments
  end

  #Stores the ARR into my_comments
  #Create a new Array array_of_venue_ids
  #Each loop through my_comments and add JUST the venue_id
  def commented_venues

    my_comments = self.comments
    
    array_of_venue_ids = Array.new

    my_comments.each do |a_comment|
      array_of_venue_ids.push(a_comment.venue_id)
    end

    matching_venues = Venue.where({ :id => array_of_venue_ids })

    unique_matching_venues = matching_venues.distinct

    return unique_matching_venues
  end
end
