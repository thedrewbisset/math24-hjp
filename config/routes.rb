Rails.application.routes.draw do
  resource :solution, only: :create
  resource :problem, only: :new
end
