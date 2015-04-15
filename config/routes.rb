Myapp::Application.routes.draw do

  root to: 'static#index'

  devise_for :users

  devise_scope :user do
    get 'users/new', to: 'users/registrations#new_user'
    post 'users/create_user',
        to: 'users/registrations#create_user'
    get 'user/show/:id', to: 'users/registrations#show', as: :user_show
    get 'users/index', to: 'users/registrations#index'
    get 'users/edit_user/:id', to: 'users/registrations#edit_user', as: :user_edit_user
    post 'users/update_user', to: 'users/registrations#update_user'
    delete 'users/delete_user/:id', to: 'users/registrations#delete_user', as: :user_delete_user
    get 'profile', to: 'users/profiles#profile'
    get 'profile/edit', to: 'users/profiles#edit'
    post 'profile/update', to: 'users/profiles#update'
  end

  scope module: 'users' do
    resources :mall_users
    resources :user_tiendas
  end

  resources :roles

  resources :locals

  resources :malls

  resources :nivel_malls

  resources :pais

  get 'locals' => 'locals#index', as: :local_index

  get 'locals/new' => 'locals#new'

  get 'nivel_malls/index/:mall_id' => 'nivel_malls#index', as: :nivel_malls_index

  get 'nivel_malls/new/:mall_id' => 'nivel_malls#new'

  get 'nivel_malls/test_ajax' => 'nivel_malls#test_ajax'

  get 'actividad_economicas' => 'actividad_economicas#index', as: :actividad_economicas

  get 'actividad_ecnonomica' => 'actividad_economicas#show'
  
  resources :tipo_canon_alquilers

  resources :cambio_monedas
  
  resources :actividad_economicas

  resources :calendario_no_laborables

  resources :arrendatarios

  resources :tiendas

  resources :ventas

  scope module: 'dynamic' do
    post 'dynamic_add_actividad/actividad'
  end
end
