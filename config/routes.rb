Myapp::Application.routes.draw do

  resources :cuenta_bancaria

  resources :bancos

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

  get 'actividad_economica' => 'actividad_economicas#show'
  
  resources :tipo_canon_alquilers

  resources :cambio_monedas
  post 'cambio_monedas/mf_cambio_moneda'
  
  resources :actividad_economicas

  resources :calendario_no_laborables

  resources :arrendatarios

  resources :tiendas
  post 'tiendas/mf_dynamic_filter'

  resources :ventas

  resources :contrato_alquilers


  get 'cobranza_alquiler' => 'ventas#cobranza', as: :cobranza_alquiler

  get 'ventas_tiendas/:tienda_id' => 'ventas#index', as: :ventas_tienda

  get 'ventas_mes_tiendas' => 'ventas#index', as: :ventas_mes_tienda

  get 'ventas_mall_tiendas' => 'ventas#mall_tiendas', as: :ventas_mall_tiendas

  get 'ventas_mensuales_mall' => 'ventas#mensuales', as: :ventas_mensuales_mall

  get 'pago_alquilers/new_transferencia' => 'pago_alquilers#new_transferencia', as: :registrar_pago_transferencia
  post '/pago_alquilers/create' =>  'pago_alquilers#create'
  get 'pago_alquilers/new_cheque_efectivo' => 'pago_alquilers#new_cheque_efectivo', as: :registrar_pago_cheque_efectivo
  post '/pago_alquilers/create_cheque' =>  'pago_alquilers#create_cheque'

  resources :pago_alquilers

  scope module: 'dynamic' do
    post 'dynamic_add_actividad/actividad'
    post 'dynamic_venta_diaria/venta'
    post 'dynamic_venta_diaria/guardar_ventas'
    post 'dynamic_venta_auditoria/auditoria'
    post 'dynamic_ventas_mes/ventas'
    post 'dynamic_pago_alquilers/recibos_cobro'
    post 'dynamic_pago_alquilers/actualizar_pagos'
    post 'dynamic_add_nivel_mall/guardar'
  end

  #CONTROLADOR DE NOTIFICACIONES MAILERS
  get 'notificar_usuarios_mall', to: 'mail_notifications#mf_notify_tiendas_mall'

  #ESTADISTICAS
  get 'estadisticas/intermensuales_ventas_alquiler', to: 'estadisticas#mf_intermensuales_vxa'
  post 'estadisticas/intermensuales', to: 'estadisticas#filtro_intermensuales'
  get 'estadisticas/mensuales_ingresos_alquiler', to: 'estadisticas#mf_mensuales_vxa'
  post 'estadisticas/mensuales', to: 'estadisticas#filtro_mensuales'
end
