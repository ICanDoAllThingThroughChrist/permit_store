class Order_of_permit < ApplicationRecord
    belongs_to :order
    belongs_to :permit
end