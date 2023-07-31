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
    end
  end
end
