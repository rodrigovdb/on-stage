ROUTE_PATH_NAMES = { new: 'cadastrar', edit: 'alterar', destroy: 'excluir' }.freeze

Rails.application.routes.draw do
  resources :bands, path: 'minhas-bandas', path_names: ROUTE_PATH_NAMES do
  end

  get '/notice', to: 'bands#clear_message'

  devise_for :users, path: '', path_names: {
    sign_in: 'entrar',
    sign_out: 'sair',
    password: 'secret',
    confirmation: 'confirmacao',
    unlock: 'desbloquear',
    registration: 'registrar',
    sign_up: 'cadastrar'
  }

  root 'main#index'
end
