Rails.application.routes.draw do

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications

  end

  namespace :api do
    namespace :v1 do
        namespace :user_management do
          resources :users do
            collection do
              put 'update_profile'
            end
          end
          post 'login', to: 'auth#login'
          delete 'logout', to: 'auth#destroy'
          put 'change_password', to: 'auth#update_password'
        end

        namespace :container_management do
          resources :containers do
            get 'logs', on: :member, to: 'containers#show_logs'
            get 'comments', on: :member, to: 'containers#show_comments'
            resources :activity do
              resources :items
              # resources :logs
              collection do
                put 'change_status'
              end

            end

          end
        end

        namespace :customer_management do
          resources :customers
        end

    end
  end
end
