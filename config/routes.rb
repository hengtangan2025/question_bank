QuestionBank::Engine.routes.draw do
  root 'home#index'
  resources :questions do
    collection do
      get :new_bool
      get :new_single_choice
      get :new_mapping
      get :new_multi_choice
      get :new_essay
      get :new_fill
      get :edit_bool
    end
  end
end
