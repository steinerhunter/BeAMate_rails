class RenameRequestPostsToRequestposts < ActiveRecord::Migration
  def up
    rename_table :request_posts, :requestposts
  end

  def down
    rename_table :requestposts, :request_posts
  end
end
