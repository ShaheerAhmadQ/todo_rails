class TasksController < ApplicationController

    before_action :temp_obj, only: [:create]

    def index
        @tasks = Task.where(is_deleted: false).all()
    end

    def show
        @task = Task.where(is_deleted: false).find(params[:id])
    end

    def edit
        render plain: @task.inspect
        #@task = Task.where(is_deleted: false).find(params[:id])
        #if @task.update(title: params[:title], body:params[:title], status: params[:status])
        #    p "responding with Updated Task : #{@task.inspect}"
        #    redirect_to @task
        #else
        #    p "responding with Error Updating Task : #{@task.errors.full_messages}"
        #    render 'edit'
        #end
    end

    def create
        @task = Task.new(title: params[:title], body:params[:title])
        @task.save
        if @task.persisted?
            p "responding with persisted Task : #{@task.inspect}"
            redirect_to @task
        else
            p "responding with Error Creating Task : #{@task.errors.full_messages}"
            render 'new'
        end
    end

    def destroy
        @task = Task.where(id: params[:id])
        if @task.blank?
            render plain: "No Such record exists"
        else
            @task.update(is_deleted: true)
            redirect_to action: 'index'
        end
    end

    private def temp_obj
        @task = Task.new
    end
end
