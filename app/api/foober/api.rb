module Foober
  class API < Grape::API
    format :json
    content_type :json, "application/json;charset=UTF-8"
    version 'v1', using: :path
    prefix 'api'

    resource :notify do
      desc 'send pending order'
      get do
        order = Order.where('status = ?', :pending).first
        if order
          [{
            order: {
              id: order.id
            },
            user: {
              name: order.user.name,
              address: order.user.address
            }
          }]
        end
      end
    end

    resource :check_order do
      desc 'chef confirm order'
      post ':id' do
        order = Order.find(params[:id])
        order.chef_confirm
        Rails.logger.info(params)
      end
    end

    resource :recieve_recipe do
      desc 'get menu tonight'
      get ':id' do
        order = Order.find(params[:id])
        recipe = order.recipe
        if order.set_up?
          [{
            order: {
              id: order.id
            },
            recipe: {
              name: recipe.name,
              content: recipe.content
            }
          }]
        end
      end
    end

    resource :finish_cooking do
      desc 'chef: I should go'
      post ':id' do
        order = Order.find(params[:id])
        if order.set_up?
          order.finish
          Feedback.create(order: order)
        end
      end
    end

    resource :chef_feedback do
      desc 'costum hater'
      post ':id' do
        order = Order.find(params[:id])
        feedback = Feedback.where(order: order)
        feedback.chef_to_user = params[:comment]
      end
    end

  end
end