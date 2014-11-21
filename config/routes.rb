Rails.application.routes.draw do

  resources :djs
  resources :votes

  get 'collectors/event', to: 'collectors#event', as: 'events_collector'
  post 'collectors/event/edit', to: 'collectors#edit_collector_event', as: 'edit_collector_event'


  get 'start', to: 'mobile#start', as: 'start'

  get 'choose_dj', to: 'mobile#djs', as: 'djs_mobile'
  post 'create_vote', to: 'mobile#create_vote', as: 'create_vote'

  get 'ruleta', to: 'mobile#spin', as: 'ruleta'

  post 'save_gift', to: 'mobile#save_gift', as: 'save_gift'
  get 'events/:event_id/gifts', to: 'gifts#generate_gifts', as: 'generate_gifts'
  post 'events/creating_gifts', to: 'gifts#creating_gifts', as: 'creating_gifts'

  get 'club', to: 'mobile#club', as: 'club'
  get 'end', to: 'mobile#end', as: 'end'

  post 'select_activity', to: 'mobile#select_activity', as: 'select_activity'
  get 'select_friend', to: 'mobile#select_friend', as: 'select_friend'
  post 'publishing_post', to: 'mobile#publishing_post', as: 'publishing_post'
  post 'upload', to: 'mobile#upload', as: 'upload'

  resources :events
  resources :gifts
  resources :entries
  resources :customers
  #resources :collectors
  get 'collectors', to: 'collectors#index', as: 'collector_index'

  #get 'collectors/new', to: 'collectors#new', as: 'new_collector'
  #get 'collectors/edit/:id', to: 'collectors#edit', as: 'edit_collector'
  #post 'collectors/:id', to: 'collectors#create'
  #post 'collectors/:id', to: 'collectors#update'
  #put 'collectors/:id', to: 'collectors#update'

  devise_for :users
  devise_scope :user do
    get "acceder", to: "devise/sessions#new"
  end

  devise_for :collectors
  #devise_scope :collectors do
  #  get "sign_in" => "devise/sessions#new", :as => :logins_sign_in
  #  get "collectors/new" => "devise/registrations#new", :as => :logins_referrals
  #end


  #root 'mobile#social'
  root 'mobile#start'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
