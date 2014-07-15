object @user

node(:follower_count) { @user.followers.count }
node(:following_count) { @user.followed_users.count }
node(:followed) { current_api_user.followed?(@user.id) }

extends "api/v1/users/index"
