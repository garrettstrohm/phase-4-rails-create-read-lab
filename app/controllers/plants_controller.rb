class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_record_not_found
    def index
        plants = Plant.all
        render json: plants, status: :ok
    end

    def show
        plant = find_plant
        render json: plant, status: :ok
    end
    
    def create
        plant = Plant.create!(plant_params)
        render json: plant, status: :created
    end

    private 

    def plant_params
        params.permit(:name, :image, :price)
    end

    def find_plant
        Plant.find_by(id: params[:id])
    end

    def rescue_from_record_not_found(invalid)
        render json: {error: invalid.records.errors.full_messages}, status: :not_found
    end

end
