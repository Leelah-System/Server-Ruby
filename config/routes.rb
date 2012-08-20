LeelahSystemServer::Application.routes.draw do
=begin
  # Admin part "/admin_leelah/..."
  namespace :admin_leelah, :defaults => { :format => "html" } do
    root  :to => "dash_board#index"

    # login "/admin_leelah/login"
    get "login" => "session#login"
    # login "/admin_leelah/logout"
    get "logout" => "session#logout"
    # login "/admin_leelah/authenticate"
    match "authenticate" => "session#authenticate", :via => :post

    # DashBoard "/admin_leelah/dash_board"
    get "dash_board/index"

    # Catalog management "/admin_leelah/catalog_management/..."
    namespace :catalog_management do
      root  :to => "products#index"

      # Categories management "/admin_leelah/catalog_management/categories/..."
      resources :categories

      # Products management "/admin_leelah/catalog_management/products/..."
      resources :products

    end

    # Order Management "/admin_leelah/order_management/..."
    namespace :order_management do
      root  :to => "orders#index"

      # Orders management "/admin_leelah/order_management/orders..."
      resources :orders

    end

    # General Configuration "/admin_leelah/general_configuration/..."
    namespace :general_configuration do
      root  :to => "users#index"

      # Users management "/admin_leelah/general_configuration/users/..."
      resources :users

    end

  end
=end

  # API part => "/api/..."
  namespace :api, :defaults => {:format => "json"} do

    # Authentication "/api/authenticate"
    match "authenticate" => "user#authenticate", :via => :post
    # Sign up "/api/sign_up"
    match "sign_up" => "user#sign_up", :via => :post

    # Actions need to authenticate with "token" "/api/:token/..."
    scope "/:token" do

      # Catalog "/api/:token/catalog/..."
      namespace :catalog do

        # Products "/api/:token/catalog/products..."
        resources :products,    :only => [:index, :show, :create, :update, :destroy]

        # Categories "/api/:token/catalog/categories..."
        resources :categories,  :only => [:index, :show, :create, :update, :destroy]
      end

      # Orders "/api/:token/orders..."
      resources :orders,  :only => [:index, :show, :create, :update, :destroy]

    end

  end
end
