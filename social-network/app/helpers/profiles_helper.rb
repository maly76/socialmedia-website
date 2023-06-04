module ProfilesHelper
    def is_friend(user)
        Friendship.where("user_id = ? OR friend_id = ?", user, user).any?
    end

    def is_requested(user)
        FriendshipRequest.where("from_user_id = ? AND to_user_id = ?", current_user, user).any? 
    end
end
