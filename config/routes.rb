Rails.application.routes.draw do
  resources :bands, path: 'minhas-bandas', path_names: { new: 'cadastrar', edit: 'alterar', destroy: 'excluir' } do
    resources :songs,     path: 'minhas-musicas', path_names: { new: 'cadastrar', edit: 'alterar', destroy: 'excluir' }
    resources :setlists,  path: 'meus-setlists',  path_names: { new: 'cadastrar', edit: 'alterar', destroy: 'excluir' } do
      collection do
        get '/:id/play/:song_id', to: 'setlists#play', as: :play
      end
    end
  end

  scope '/minhas-bandas' do
    get     '/:id/convidar-membros',        to: 'bands#invite_people',  as: :invite_people
    post    '/:id/convidar-membros',        to: 'bands#join_members',   as: :join_members
    delete  '/:id/remover-membro/:member',  to: 'bands#remove_member',  as: :remove_member
  end

  devise_for :users, path: '', path_names: { sign_in: 'entrar', sign_out: 'sair', password: 'secret', confirmation: 'confirmacao', unlock: 'desbloquear', registration: 'registrar', sign_up: 'cadastrar' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'
end
