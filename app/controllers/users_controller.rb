class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :new]
  before_action :fetch_user, only: [:show, :edit, :update]
  before_action :current_user_is_user_post, only: [:update]
  before_action :current_user_is_user, only: [:edit]
  before_action :user_info_exists, only: [:update]
  before_action :user_links_exists, only: [:update]

  def index
    @users = User.all
  end

  def show

  end

  def edit
    @user.user_info.user_links.build
  end

  def update
    @user.update!(user_params)
    redirect_to edit_user_path(@user)
  end

private
  def user_params
		params.require(:user).permit(:id, :nickname,
			:user_info_attributes => [:id, :avatar, :description, :favorites_are_showable, :utauloids_are_showable, :notif_when_vb_updated, :notif_when_utauloid_faved, :notif_when_utauloid_commented,
				:user_links_attributes => [:id, :link, :_destroy]
			]
		)
  end

  def fetch_user
    @user = User.friendly.find(params[:id])
    # TODO : handle redirection
  end

  def destroy
    current_user.destroy
  end

  def current_user_is_user_post
    if current_user != User.friendly.find(params[:id])
      # Display error message && do something
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def current_user_is_user
    if current_user != @user
      # Display error message && do something
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def user_info_exists
    if !UserInfo.exists?(id: user_params[:user_info_attributes][:id], user_id: current_user.id)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def user_links_exists
    links = []
    p = user_params
    p[:user_info_attributes][:user_links_attributes].each do |l|
      id = nested_hash_value(l, :id) # = l.second[:id]
      links.push(id) unless id.nil?
    end

    if UserLink.where(id: links, user_info_id: p[:user_info_attributes][:id]).size != links.size
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def nested_hash_value(obj, key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end
end
