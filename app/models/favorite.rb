class Favorite < ActiveRecord::Base
  validates_presence_of :address, :user_id, :uniqueness => true
  belongs_to :favorable
  belongs_to :user
end



# when they log in, a link on user show page, go to favorites link and also in results, save to favorites.
# that goes to favorites controller. 

# create link helpers

# create a favorite by add new favorite
#   redirect to the favorite index page that shows all the favorites. 

# results is the 'new' page so don't need a new. 


# template for favorites#index

# favorites#index make each address linked as form input so that when you click on the link it redirects to search and shows the nearest dock.