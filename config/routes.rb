Rails.application.routes.draw do
  resources :users do
    resources :posts
    resources :followings
  end

  # You can have multiple resources entries pointing at the same controller.
  # Just make sure that the controller can deal with both situations!
  resources :posts

  root to: 'posts#index'
end
