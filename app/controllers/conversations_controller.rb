class ConversationsController < ApplicationController
  before_filter :signed_in_user
  helper_method :mailbox, :conversation
  respond_to :html, :js

  def new
    if params[:recipient_id]
      @recipient = User.find_by_id(params[:recipient_id])
    end
    render "new.html.erb", :layout => false
  end

  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all
    @conversation = current_user.send_message(recipients, *conversation_params(:body, :subject))
    if @conversation.errors.blank?
      current_user.add_mate_points(BeAMateRails::Application::MESSAGE_MATE_POINTS)
      flash[:earn_mate_points] = "You've just earned #{BeAMateRails::Application::MESSAGE_MATE_POINTS} Mate Points! Keep up the good work!"
      respond_with(@conversation, :location => root_path)
    end
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    current_user.add_mate_points(BeAMateRails::Application::MESSAGE_MATE_POINTS)
    flash[:earn_mate_points] = "You've just earned #{BeAMateRails::Application::MESSAGE_MATE_POINTS} Mate Points! Keep up the good work!"
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
        when 0 then self
        when 1 then self[subkeys.first]
        else subkeys.map{|k| self[k] }
      end
    end
  end
end
