class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  # add routes
  get '/bakeries' do 
    bakeries = Bakery.all 
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery = bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    baked_goods = BakedGood.all.order(price: :desc)
    baked_goods = baked_goods.to_json(only: [:name, :price])
  end

  get '/baked_goods/most_expensive' do 
    baked_goods = BakedGood.all.order(price: :desc).limit(1)
    baked_goods = baked_goods.to_json(only: [:name, :price])
  end

end

# get '/games/:id' do
#   # look up the game in the database using its ID
#   game = Game.find(params[:id])
#   # send a JSON-formatted response of the game data
#   #game = game.to_json(include: {reviews: {include: :user}})
#   game.to_json(only: [:id, :title, :genre, :price], include: {
#     reviews: { only: [:comment, :score], include: {
#       user: { only: [:name] }
#     } }
#   })
# end