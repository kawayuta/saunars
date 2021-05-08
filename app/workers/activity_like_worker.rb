class ActivityLikeWorker
    include Sidekiq::Worker
  
    def perform(action, user_id, activity_id)
      
      if action == "create"
        unless Like.find_by(activity_id: activity_id, user_id: user_id).present?
          Like.create(activity_id: activity_id, user_id: user_id)
          puts "いいね"
        else
          puts "いいね済み"
        end
      elsif action == "destroy"
        like = Like.find_by(activity_id: activity_id, user_id: user_id)
        if like.present?
            like.destroy
            puts "いいね取り消し"
        end
      end
  
    end
  
  end
  