class Order < ApplicationRecord
    attr_accessor :title, :permits_attribute
    has_many :permits, dependent: :destroy
    accepts_nested_attributes_for :permits, allow_destroy:true
    belongs_to :user, touch:true 
    belongs_to :subscription, touch:true
end
