class RenameMicropostsToRequestPosts < ActiveRecord::Migration
  def up
    rename_table :microposts, :requests_posts
  end

  def down
    rename_table :requests_posts, :microposts
  end
end
