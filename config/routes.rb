CargaMasiva::Application.routes.draw do
      
  root "pages#home"
  
  get "/home", to: "pages#home", as: "home"
  
  resource :bls do
    collection do 
      get :index
      post :importar
    end
  end

  resource :equipos
  resource :entidades

  resource :importaciones
end
