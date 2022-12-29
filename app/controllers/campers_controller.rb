class CampersController < ApplicationController
    
    def index
        render json: Camper.all
    end

    def show
        camper = Camper.find_by_id(params[:id])
        if camper
            render json: camper, serializer: CamperWithActivitiesSerializer
        else
            render json: {error: "Camper not found"}, status: :not_found
        end    
    end

    def create
        # initialized camper
        camper = Camper.create(camper_params)
        if camper.valid?
            render json: camper, status: :created
        else
            render json: {errors: camper.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    # def find_camper
    #     Camper.find(params[:id])
    # end

    # def record_not_found
    #     render json: {error: "Camper not found"}, status: :not_found
    # end
end
