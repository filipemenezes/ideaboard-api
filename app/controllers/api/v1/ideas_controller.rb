module Api
  module V1
    class IdeasController < ApplicationController
      before_action :set_idea, only: [:update, :destroy]

      def index
        @ideas = Idea.order(created_at: :desc)
        render json: @ideas
      end

      def create
        @idea = Idea.create(idea_params)
        render json: @idea
      end

      def update
        @idea.update_attributes(idea_params)
        render json: @idea
      end

      def destroy
        if @idea.destroy
          head :no_content, status: :ok
        else
          render json: @idea.errors, status: :unprocessable_entity
        end
      end

      private

      def set_idea
        @idea = Idea.find(params[:id])
      end

      def idea_params
        params.require(:idea).permit(:title, :body)
      end
    end
  end
end
