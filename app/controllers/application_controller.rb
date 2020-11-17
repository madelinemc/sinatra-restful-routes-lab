class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do #INDEX
    @recipes = Recipe.all
    
    erb :'/index'
  end

  get '/recipes/new' do #NEW render the erb form to create an instance of a recipe

    erb :'/new'
  end

  post '/recipes' do #CREATE
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
  
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do #SHOW
    @recipe = Recipe.find_by_id(params[:id])
    
    erb :'/show'
  end
  
  get '/recipes/:id/edit' do #EDIT
    @recipe = Recipe.find_by_id(params[:id])

    erb :'/edit'
  end

  patch '/recipes/:id' do #UPDATE
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do #DESTROY
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete

    redirect to '/recipes'
  end

end
