class HelloWorker
  include Sidekiq::Worker

  def perform(action, user_id, sauna_id)
    
    if action == "create"
      Went.createWent(user_id, sauna_id)
    elsif action == "delete"
      went = Went.find_by(sauna_id: sauna_id, user_id: user_id)
      went.destroy
    end

  end

end
