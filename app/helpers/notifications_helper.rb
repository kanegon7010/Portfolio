module NotificationsHelper
  def unchecked_notifications
    notifications = current_user.passive_notifications.where(checked: false).where.not(action: 'message')
    @notifications_count = notifications.size
  end

  def unchecked_dm_notifications
    notifications_dm = current_user.passive_notifications.where(checked: false, action: 'message')
    @notifications_dm_count = notifications_dm.size
  end

  def unread_messages_notifications(unread_messages)
    unread_messages = current_user.passive_notifications.where(checked: false, action: 'message', message_id: unread_messages)
    @unread_messages_count = unread_messages.size
  end

end
