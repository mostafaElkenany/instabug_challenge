class AddDefaultValueToMessagesCount < ActiveRecord::Migration[7.0]
  def change
    change_column_default :chats, :messages_count, 0
  end
end
