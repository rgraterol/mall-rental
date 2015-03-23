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


    # You can have the root of your site routed with "root"

  # # All routes
  # get "dashboards/dashboard_1"
  # get "dashboards/dashboard_2"
  # get "dashboards/dashboard_3"
  # get "dashboards/dashboard_4"
  # get "dashboards/dashboard_4_1"
  #
  # get "layoutsoptions/index"
  #
  # get "graphs/flot"
  # get "graphs/morris"
  # get "graphs/rickshaw"
  # get "graphs/chartjs"
  # get "graphs/peity"
  # get "graphs/sparkline"
  #
  # get "mailbox/inbox"
  # get "mailbox/email_view"
  # get "mailbox/compose_email"
  # get "mailbox/email_templates"
  # get "mailbox/basic_action_email"
  # get "mailbox/alert_email"
  # get "mailbox/billing_email"
  #
  # get "widgets/index"
  #
  # get "forms/basic_forms"
  # get "forms/advanced"
  # get "forms/wizard"
  # get "forms/file_upload"
  # get "forms/text_editor"
  #
  # get "appviews/contacts"
  # get "appviews/profile"
  # get "appviews/projects"
  # get "appviews/project_detail"
  # get "appviews/file_menager"
  # get "appviews/calendar"
  # get "appviews/faq"
  # get "appviews/timeline"
  # get "appviews/pin_board"
  #
  # get "pages/search_results"
  # get "pages/lockscreen"
  # get "pages/invoice"
  # get "pages/invoice_print"
  # get "pages/login"
  # get "pages/login_2"
  # get "pages/register"
  # get "pages/not_found_error"
  # get "pages/internal_server_error"
  # get "pages/empty_page"
  #
  # get "miscellaneous/notification"
  # get "miscellaneous/nestablelist"
  # get "miscellaneous/timeline_second_version"
  # get "miscellaneous/forum_view"
  # get "miscellaneous/forum_post_view"
  # get "miscellaneous/google_maps"
  # get "miscellaneous/code_editor"
  # get "miscellaneous/modal_window"
  # get "miscellaneous/validation"
  # get "miscellaneous/tree_view"
  # get "miscellaneous/chat_view"
  #
  # get "uielements/typography"
  # get "uielements/icons"
  # get "uielements/draggable_panels"
  # get "uielements/buttons"
  # get "uielements/video"
  # get "uielements/tables_panels"
  # get "uielements/notifications_tooltips"
  # get "uielements/badges_labels_progress"
  #
  # get "gridoptions/index"
  #
  # get "tables/static_tables"
  # get "tables/data_tables"
  # get "tables/jqgrid"
  #
  # get "gallery/basic_gallery"
  # get "gallery/bootstrap_carusela"
  #
  # get "cssanimations/index"

end
