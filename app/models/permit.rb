class Permit < ApplicationRecord
    #resourcify
    has_many :permit_tasks, dependent: :destroy
    has_many :tasks, through: :permit_tasks
    accepts_nested_attributes_for :tasks
    belongs_to :user 
    belongs_to :order, touch: true
    scope :permits_received, -> {where(received: true)}
 
    def add_task(task_id)
        permit_task = self.permit_tasks.find_by(task_id: task_id)
        if permit_task 
            permit_task.quantity += 1
        else 
            permit_task= self.permit_tasks.build(task_ids: task_id)
        end 
        permit_task 
    end

    def self.permits_received
        where(received: true)
    end

    def tasks_attributes=(task_attributes)#a method provided by accepts_nested_attributes_for :task
        #@box = set_box
        permits= []
        permits2= []
        permits3= []
        task_attributes.each do |key, value|
            if key == "0"##binding.pry
                if value[:title].present?
                    ##binding.pry#self?
                    new_task= task.find_by(title: value[:title])
                    self.permit_tasks                
                    # #binding.pry
                    if new_task.present?
                        self.permit_tasks.each {|i| 
                            if i.task_id == new_task.id
                            #binding.pry
                                i.quantity +=1
                            end
                                            }
                        #binding.pry
                    elsif new_task.present? == false
                        new_task2= task.create(title: value[:title])
                        self.permit_tasks.build(task_id: new_task2.id)
                        #binding.pry
                       self.permit_tasks.each {|i| permits << i.task_id }
                    end
                #binding.pry
                end
            elsif key == "1"
                if value[:title].present?
                    new_task= task.find_by(title: value[:title])
                    self.permit_tasks
                    if new_task.present?
                        self.permit_tasks.each {|i| 
                            if i.task_id == new_task.id
                            #binding.pry
                                i.quantity +=1
                            end
                                            }
                        #binding.pry
                    elsif new_task.present? == false
                        new_task2= task.create(title: value[:title])
                        self.permit_tasks.build(task_id: new_task2.id)
                        #binding.pry
                       self.permit_tasks.each {|i| permits2 << i.task_id }
                    end
                end
            elsif key == "2"
                if value[:title].present?
                    new_task= task.find_by(title: value[:title])
                    self.permit_tasks
                    if new_task.present?
                        self.permit_tasks.each {|i| 
                            if i.task_id == new_task.id
                            #binding.pry
                                i.quantity +=1
                            end
                                            }
                        #binding.pry
                    elsif new_task.present? == false
                        new_task2= task.create(title: value[:title])
                        self.permit_tasks.build(task_id: new_task2.id)
                        #binding.pry
                       self.permit_tasks.each {|i| permits3 << i.task_id }
                    end
                end
            end 
            permits
            #binding.pry
        end
        ##binding.pry
        permits
        permits2
        permits3
        #binding.pry
    end
end