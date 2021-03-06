class MessagesController < ApplicationController
	before_action :authenticate_user!

	def index
		if !params[:filters].blank?
			@messages = current_user.messages.where(deleted: !params[:bin].blank?, message_type: get_filtered_message_types(params[:filters]))
		else
			@messages = current_user.messages.where(deleted: !params[:bin].blank?)
		end

		@page_title = current_user.nickname
	end

	def show
		@message = current_user.messages.find(params[:id])
		@message.seen = true
		@message.save

		@page_title = current_user.nickname
	end

	def create
		
	end

	def mark_as_seen
		current_user.messages.find(params[:id]).update_attributes({ seen: true })
		redirect_to messages_path
	end

	def mark_as_not_seen
		current_user.messages.find(params[:id]).update_attributes({ seen: false })
		redirect_to messages_path
	end

	def add_multiple_to_bin
		if !params[:delete_messages].blank?
			current_user.messages.where(id: get_messages_ids_params[:delete_messages]).update_all({ deleted: true })
		end
		redirect_to messages_path
	end

	def add_to_bin
		current_user.messages.find(params[:id]).update_attributes({ deleted: true })
		redirect_to messages_path
	end

private
	def get_messages_ids_params
		params.permit({ :delete_messages => [] },)
	end

	def get_filtered_message_types(filters)
		r = []
		r.push(Message.message_types[:notif_new_comment]) if filters.include?("new_comment")
		r.push(Message.message_types[:notif_new_favorite]) if filters.include?("new_favorite")
		r.push(Message.message_types[:notif_new_update]) if filters.include?("favorite_updated")

		r
	end
end
