Rails.application.routes.draw do
  default_url_options host: Settings.host, port: Settings.port

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'dashboard#index'

  # ==========================================================================================================
  # Projects =================================================================================================
  # ==========================================================================================================

  get :projects,
    to: 'projects#index',
    as: :projects

  get 'projects/new',
    to: 'projects#new',
    as: :new_project

  post 'projects',
    to: 'projects#create',
    as: :create_project

  get 'projects/:slug',
    to: 'projects#show',
    as: :project

  # ==========================================================================================================
  # Tasks ====================================================================================================
  # ==========================================================================================================

  get 'projects/:slug/tasks',
    to: 'tasks#index',
    as: :tasks

  get 'projects/:slug/tasks/new',
    to: 'tasks#new',
    as: :new_task

  post 'projects/:slug/tasks',
    to: 'tasks#create',
    as: :create_task

  patch 'projects/:slug/tasks/:id',
    to: 'tasks#update',
    as: :update_task

  get 'projects/:slug/tasks/:id',
    to: 'tasks#show',
    as: :task

  get 'projects/:slug/tasks/:id/edit',
    to: 'tasks#edit',
    as: :edit_task

  post 'projects/:slug/tasks/:id/close',
    to: 'tasks#close',
    as: :close_task

  post 'projects/:slug/tasks/:id/reopen',
    to: 'tasks#reopen',
    as: :reopen_task

  delete 'projects/:slug/tasks/:id',
    to: 'tasks#destroy',
    as: :destroy_task

  # ==========================================================================================================
  # Task comments ============================================================================================
  # ==========================================================================================================

  post 'projects/:slug/tasks/:id/comment',
    to: 'task_comments#create',
    as: :create_task_comment

  # ==========================================================================================================
  # Users ====================================================================================================
  # ==========================================================================================================

  get 'users/:username',
    to: 'users#show',
    as: :user
end
