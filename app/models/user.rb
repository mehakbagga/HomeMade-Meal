class User < ApplicationRecord
    has_many :meals, dependent: :destroy
    has_many :reviews, dependent: :destroy
    has_many :orders, dependent: :destroy

    before_validation :downcase_email
    validates :email, presence: true, uniqueness: {case_sensitive: false}, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
    has_secure_password

  
    def downcase_email
        self.email = self.email.downcase
    end

    def cook_rating
        if self.is_cook && self.meals
            ratings_sum = 0
            reviews_number = 0
            meals = self.meals
            meals.each do |meal|    
                meal.reviews.each do |review|
                    ratings_sum+=review.rating
                    reviews_number+=1
                end
            end

            if reviews_number != 0
                avg_rating = ((ratings_sum).to_f/(reviews_number).to_f).round(2)
            else  
                0
            end

        end
    end
end
