Rails.application.routes.draw do
  resources :stocks
  resources :sales
  resources :purchases, only: [:new, :create]

  get 'reports/monthly_profit_or_loss', to: 'reports#monthly_profit_or_loss', as: 'reports_monthly_profit_or_loss'

  root to: 'stocks#index'
end
