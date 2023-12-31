# frozen_string_literal: true

class AddforeignkeyPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :author, null: true, foreign_key: { to_table: :users }
  end
end
