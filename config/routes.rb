InnerPlan::Engine.routes.draw do
  resources :tasks, only: [] do
    resources :attachments, except: [:show]
  end
end
