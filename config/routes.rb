Rails.application.routes.draw do 
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check
  root "categories#index"

  resources :categories do
    resources :tasks
  end

  # ✅ Custom route for marking a task as completed
  patch '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'
end
