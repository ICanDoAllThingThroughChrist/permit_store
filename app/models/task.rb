class Task < ApplicationRecord
    attr_accessor :image_cache, :image
    #belongs_to :permit_item
    has_many :permit_tasks 
    has_many :permits, through: :permit_tasks
    mount_uploader :image, ImageUploader
    validate :image_size

    before_destroy :ensure_not_referenced_by_any_permit_item
    def permit_name=(name)
        self.permit = permit.find_or_create_by(title: title)
      end
    
      def permit_name
         self.permit.name
      end
    
    private 
    # def ensure_not_referenced_by_any_permit_item
    #     unless :permit_tasks.empty? 
    #         errors.add(:base, 'permit tasks present') 
    #         throw :abort 
    #     end 
    # end 

    def image_size 
        if image.size > 5.megabytes 
            errors.add(:image, "should be less than 5MB")
        end 
    end
end
