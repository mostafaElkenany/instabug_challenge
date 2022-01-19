class AddChatsCountToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :chats_count, :integer, default: 0
    Application.all.each do |application|
      Application.update_counters application.id, chats_count: application.chats.length
    end
  end
end
