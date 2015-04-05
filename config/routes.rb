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
  end

  resources :roles

  resources :nivel_malls

  resources :malls

  resources :pais

  resources :tipo_canon_alquilers

  resources :cambio_monedas

  resources :canon_alquilers

  resources :actividad_economicas

  resources :calendario_no_laborables

  resources :locals

  get 'locals/:id/localsmall' => 'locals#localsmall'
end
