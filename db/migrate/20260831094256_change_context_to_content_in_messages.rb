class ChangeContextToContentInMessages < ActiveRecord::Migration[8.0]
  def change
    remove_column :messages, :context, :text
    add_column :messages, :content, :text
  end
end
