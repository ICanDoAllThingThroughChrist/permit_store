class PermitTask < ApplicationRecord
    belongs_to :permit, touch:true  
    belongs_to :task, touch:true 
    # belongs_to :task
    # attr_accessor :quantity
    # attr_writer :quantity 
    # attr_reader :quantity
    def create
        current_user.create_current_permit unless current_user.current_permit
        permit_task = current_user.current_permit.add_task(params[:task_id])
        if permit_task.save
          redirect_to permit_path(current_user.current_permit), {notice: 'task added to permit!'}
        else
          redirect_to permit_path, {notice: 'Unable to add task'}
        end
    end
end
