class ReviewsController < ApplicationController
    before_action :find_meal
    
    def create
        @review = Review.new params.require(:review).permit!
        @review.meal = @meal
        @review.user = current_user
        if @review.save
            
            redirect_to meal_path(@meal), notice: "Reveiw Posted"
        else
           
            redirect_to meal_path(@meal), notice: "Can't Post Review"
        end
    end

    def destroy
        @review = Review.find params[:id]
        @review.destroy
        flash[:alert] = "Review Deleted"
        redirect_to show_admin_panel_user_path(current_user)
    end

    def update
        @review = Review.find(params[:id])
        if(can? :crud, @meal)
            if @review.update(is_approved: true)
                redirect_to meal_path(@meal),notice: notice
            else
                redirect_to meal_path(@meal), alert: "Something went wrong"
            end
        else
            if @review.update(params.require(:review).permit!)
                redirect_to meal_path(@meal), notice: "Review Updated!"
            else
                redirect_to meal_path(@meal), alert: "Something went wrong"
            end
        end
    end

    def find_meal
        @meal = Meal.find(params[:meal_id])
    end
end
