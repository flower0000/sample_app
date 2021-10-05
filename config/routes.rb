Rails.application.routes.draw do
  get 'todolists/new'
  #URLとコントローラー#アクション表記が同じ場合は書く必要なし(/と#を同じと捉える)
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'top' => 'homes#top'
  post 'todolists' => 'todolists#create'
  get 'todolists' => 'todolists#index'
  #.../todolists/1や.../todolists/3に該当する
  get 'todolists/:id' => 'todolists#show', as: 'todolist'
  #as: '名前' は「名前付きルート」といい、コード内でURLをわかりやすく書くために設定し、URLとして使用。
  get 'todolists/:id/edit' => 'todolists#edit', as: 'edit_todolist'
  patch 'todolists/:id' => 'todolists#update', as: 'update_todolist'
  delete 'todolists/:id' => 'todolists#destroy',as: 'destroy_todolist'
  
end