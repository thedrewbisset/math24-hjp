Rails.application.routes.draw do
  root 'problems#new'
  resource :solution, only: :create
  resource :problem, only: :new
end
