class SubsController < ApplicationController

    before_action :ensure_moderator, only: [:edit, :update]
    before_action :require_login, except: [:show, :index]

    helper_method :current_sub

    def ensure_moderator
      @sub = Sub.find(params[:id])
      unless current_user == @sub.moderator
        flash[:errors] ||= []
        flash[:errors] << "You are not the moderator of this sub"
        redirect_to sub_url(@sub)
      end
    end

    def current_sub
      Sub.find(params[:id])
    end

    def index
      @subs = Sub.all
      render :index
    end

    def show
      @sub = Sub.find(params[:id])
      render :show
    end

    def new
      @sub = Sub.new
    end

    def create
      @sub = Sub.new(sub_params)
      @sub.moderator = current_user
      if @sub.save
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] ||= []
        flash.now[:errors] << @sub.errors.full_messages
        render :new
      end
    end

    def edit
      @sub = Sub.find(params[:id])
      render :edit
    end

    def update
      @sub = Sub.find(params[:id])
      if @sub.update_attributes(sub_params)
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] ||= []
        flash.now[:errors] << @sub.errors.full_messages
        render :edit
      end
    end

    def destroy
      @sub = Sub.find(params[:id])
      @sub.delete
    end
    private

    def sub_params
      params.require(:sub).permit(:title, :description, :user_id)
    end
end
