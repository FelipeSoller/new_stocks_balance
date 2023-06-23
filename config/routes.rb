Rails.application.routes.draw do
  resources :items
  resources :sales

  get 'reports/monthly_profit_or_loss', to: 'reports#monthly_profit_or_loss', as: 'reports_monthly_profit_or_loss'

  root to: 'items#index'
end
