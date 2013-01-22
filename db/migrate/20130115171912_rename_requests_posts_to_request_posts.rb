class RenameRequestsPostsToRequestPosts < ActiveRecord::Migration
  def up
    rename_table :requests_posts, :request_posts
  end

  def down
    rename_table :request_posts, :requests_posts
  end
end
