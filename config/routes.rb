Rails.application.routes.draw do
  devise_for :users
  resources :todos
  patch 'todos/:id/update_status', :to => 'todos#update_status', as: :update_status

  resources :projects do
    get  'add_developers', on: :member
    patch 'save_developers', on: :member
  end
  get 'projects/:id/graph', :to => 'projects#graph', as: :project_graph
  get 'graphs', to: 'dashboards#graphs', as: :graphs
  get "project_todo_list", to: 'dashboards#project_todo_list', as: :project_todo_list
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "dashboards#developers_todo_list"
end
