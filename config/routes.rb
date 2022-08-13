class UserConstraint
  def initialize(param1,actionvalue)
    @key = param1
    @action = actionvalue
    
    p @action
  end

  def matches?(req)
    req.env["devise.mapping"] = Devise.mappings[:user]
    req.parameters.keys.include?(@key) && req.params[@key] == @action
  end
end
class MyParamConstraint
  def initialize(param1)
    @key = param1
  end

  def matches?(req)
    req.env["devise.mapping"] = Devise.mappings[:user]
    req.parameters.keys.include?(@key)
  end
end
class TwoParamConstraint
  def initialize(param1,param2)
    @key = param1
    @key2 = param2
  end

  def matches?(req)
    req.env["devise.mapping"] = Devise.mappings[:user]
    req.parameters.keys.include?(@key) && req.parameters.keys.include?(@key2)
  end
end

class NoParamConstraint
  def initialize()
  end

  def matches?(req)
    req.parameters.keys.length == 0
  end
end

Rails.application.routes.draw do
  get "events/:id", to: "category/evenements#seeevent", as: :showbillet
  post "/widget_billeterie.php", to: "billeterie#widget"
  get 'billeterie', to: "billeterie#index"
  get "", to: "category/espacebrocante#see", constraints: TwoParamConstraint.new('p','post_type')
  get "", to: "presentation#search", constraints: MyParamConstraint.new('s')
  
  post "mon-compte", to: "category/espacebrocante#updatead", constraints: MyParamConstraint.new('advert_id')
  get "mon-compte", to: "category/espacebrocante#editad", constraints: MyParamConstraint.new('advert_id')
  get "wp-admin", to: redirect('mon-compte')
  post "/wp-admin/admin-ajax.php", to: "category/espacebrocante#supprad", constraints: UserConstraint.new('actions','adverts_delete')

  devise_scope :user do
    get "wp-login.php", to: "users/confirmations#registrationdisabled", as: :registrationdisabled, constraints: UserConstraint.new('registration','disabled')
    get "/mon-compte/wp-login.php", to: "users/registrations#new", as: :newregistration, constraints: UserConstraint.new('actions','register')
    get "wp-login.php", to: "users/sessions#destroyuser", as: :logout, constraints: UserConstraint.new('actions','logout')
    get "wp-login.php", to: "users/confirmations#new", as: :checkmailconfirm, constraints: UserConstraint.new('checkemail','confirm')

    post "wp-login.php", to: "users/passwords#update", constraints: UserConstraint.new('actions','resetpass')
    get "wp-login.php", to: "users/confirmations#loginstaff", constraints: UserConstraint.new('actions','administrator'), as: :loginstaff

    get "wp-login.php", to: "users/passwords#edit", as: :mynewpassword, constraints: UserConstraint.new('actions','rp')

    post "wp-login.php", to: "users/passwords#create", constraints: UserConstraint.new('actions','lostpassword')
    get "wp-login.php", to: "users/passwords#new", constraints: UserConstraint.new('actions','lostpassword')

  post "wp-login.php", to: "users/sessions#create"
  get "wp-login.php", to: "users/sessions#new"
  get "/mon-compte/wp-login.php", to: redirect("wp-login.php")
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  #login de wordpress
  get "mon-compte", to: "category/espacebrocante#moncompte", as: :moncompte
  get "/wp-login.php?action=rp", to: "devise1/password#new"
  get 'espace-vendeur', to: 'category/espacebrocante#modifierannonce', as: :modifierannonce, constraints: MyParamConstraint.new('advert_id')

    post 'espace-vendeur', to: 'category/espacebrocante#savead', constraints: UserConstraint.new('_adverts_action','save')

  get 'espace-acheteur', to: 'category/espacebrocante#espaceacheteur'
  post 'espace-acheteur', to: 'category/espacebrocante#espaceacheteur'

  get 'espace-vendeur', to: 'category/espacebrocante#espacevendeur'
  post 'espace-vendeur', to: 'category/espacebrocante#deposeruneannonce'
  get "/advert/:title/", to: "category/espacebrocante#voirannonce", as: :voirannonce
  get "/advert/:title/debloc", to: "category/espacebrocante#deblocmail", as: :debloc_ad_mail
  get "/advert/:title/voir", to: "category/espacebrocante#voirmail", as: :voir_ad_mail

  #get "/ads/:_post_id", to: 'category/espacebrocante#voirannonce'
  post "/wp-admin/admin-ajax.php", to: "category/evenements#ajax"
  get 'mediatheque', to: 'mediatheque#index'

  get 'initnbvidload', to: 'mediatheque#initnb', as: :initnb
  get '/searchmyvideo/search', to: 'mediatheque#searchvideo'
  get "fonts/:namefont", to: "presentation#font"
  get "font/:namefont", to: "presentation#font"
  post "/contact-forms/1276/feedback", to: "welcome#contactus"
  get "/category/actualites/page/:id/", to: "presentation#actualites", as: :somearticles
  get "/category/actualites/", to: "presentation#actualites", as: :somearticlesfirstpage
  get "/category/:parentcattitle/:title/", to: "category#mycat", as: :somearticles1

  get 'category/:title/', to: 'category#mycat'

  get 'myvideo', to: "mediatheque#mavideo"
  get '', to: 'welcome#index', as: :searcharticles
  get 'photos-saison-:annee1-:annee2/', to: "photos#saison20202021"
  get  "/saison-:annee1-:annee2", to: 'photos#saison20202021'
  get  "/phototheque-saison-:annee1-:annee2", to: 'photos#saison20202021'

  get 'location/instrument'
  get 'louer-une-salle', to: 'location#salle'
  get 'mediatheque/index'
  get 'evenements/:name', to: "category/evenements#voirunevenement"
  get "evenements", to: "presentation#evenements"
  get 'theatre', to: 'presentation#theatre'
  get "/category/actualites", to: "presentation#actualites"
  get 'les-cursus', to: 'viescolaire#lecursusmusique'
  get 'le-cursus-de-formation', to: 'viescolaire#lecursusdanse'
  get "/reglement-interieur-des-eleves", to: 'viescolaire#reglementeleves'
  get '/inscriptions-re-inscriptions-2020-2021', to: 'viescolaire#inscription'
  get 'viescolaire/index'
  get 'organigramme', to: 'presentation#organigramme'
  get 'le-conseil-dadministration', to: 'presentation#conseildadministration'
  get 'category/vie-scolaire', to: 'category#vie_scolaire'
  get 'postuler-au-cmdtg', to: "presentation#postuler"
  get 'historique', to: "presentation#historique"
  get 'vie-scolaire', to: 'viescolaire#index'
  get 'le-logo', to: "presentation#logo"
  get 'localisation', to: 'presentation#localisation'
  get 'edgar-nibul', to: 'presentation#edgarnibul'
  get 'les-disciplines-2', to: 'viescolaire#lesdisciplines'
  get 'les-departements-du-cmdtg', to: 'viescolaire#departements'
  get 'danse', to: 'viescolaire#danse'
  get 'musique', to: 'viescolaire#musique'
  get 'le-cmdtg', to: 'presentation#lecmdtg', as: :lecmdtg
  get 'les-cursus-du-cmdtg', to: 'viescolaire#cursus'
#  get 'videotheque', to: 'mediatheque#videotheque'
#  get 'phototheque', to: 'mediatheque#phototheque'
  get 'guide-de-la-rentree', to: 'category/actualites#guidedelarentree'
  get 'clap-de-fin-au-conservatoire', to: 'category/actualites#clapdefinauconservatoire'
  get '/contactez-le-conservatoire', to: 'welcome#contact'
  get 'projet-detablissement', to: 'viescolaire#projetdetablissement'
  get 'le-reglement-des-etudes', to: 'viescolaire#lereglementdesetudes'
  get 'reglement-interieur-des-eleves', to: 'viescolaire#reglementeleves'
  get 'louer-un-instrument', to: 'location#instrument'
  #get '/category/espace-brocante/', to: 'category/espacebrocante#index'
  get '/category/mediatheque/', to: 'mediatheque#index'
  get "/:title/embed", to: "category/actualites#showembed", as: :embed
  get "/:title/", to: "category/actualites#show", as: :show

  root to: 'welcome#index', constraints: NoParamConstraint.new()
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
