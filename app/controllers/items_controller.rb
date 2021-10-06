class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      if user
      items = user.items
      else
        return  render json: {error: "user not found"}, status: :not_found
      end
    else
    items = Item.all
  end
    render json: items, include: :user

end
def create
  user = User.find(params[:user_id])
  item = user.items.create(item_params)
  render json: item, status: :created

end
def show
  item = Item.find(params[:id])
  render json: item
end



private
def render_not_found
  render json: {error: "user not found"}, status: :not_found
end
def item_params
  params.permit(:name, :description, :price)
end
end