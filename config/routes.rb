Rails.application.routes.draw do

  resources :tags
	get 'announcement_types/index'

	resources :announcements

	get 'comment/index'
	get 'comment/show'

	devise_for :users, :controllers => { registrations: 'registrations' }

	get 'pages/index'
	get 'reports' => 'pages#reports'
	get 'useradmin' => 'pages#useradmin'

	resource :song_keys, only: [:index, :show]

	resources :notifications do
		member do
			post "updateAdminNotify"
		end
	end

    resources :tags do
		member do
            get "getTagsByType"
			post "addNewTagFromSong"
		end
	end

 	resources :schedules do
		member do
			post "addScheduleComment"
			post "deleteScheduleComment"
		end
	end

	resources :songs do
		member do
			get "getSongSchedules"
		end
	end

	resources :pages do
		member do
			post "updateAdmin"
			post "disableUser"
			post "updateUserInfo"
			post "resetPassword"
		end
	end

	resources :announcement_types do
	end

	resources :announcements do
		member do
			post "activeAnnouncement"
		end
	end

	root 'pages#index' #, path: "worship"

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

	# for Error handling and non-existent routes
	#	get "*path" => redirect("/")
end
