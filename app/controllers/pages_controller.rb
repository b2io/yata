class PagesController < ApplicationController
  skip_before_filter :authorize, only: [ :index ]

  def index
    redirect_to controller: 'pages', action: 'todos' if current_user
  end

  def todos
    @lists = List.find_all_by_user_id(current_user.id)
    gon.rabl 'app/views/lists/index.json.rabl', as: 'lists'
    gon.user_id = current_user.id
  end

  def profile
    @user = current_user
  end
end
