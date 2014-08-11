require 'sinatra'

get '/' do
  #TODO return all read items
  "brew some coffee"
end

post '/' do
  #TODO create item with params[:item_text]
end

put '/:id' do
  #TODO replace item with id params[:id] using params[:item_text]
end

delete '/:id' do
  #TODO delete item with id params[:id]
end
