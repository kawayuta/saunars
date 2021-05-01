class SaunaWentWorker
  include Sidekiq::Worker

  def perform(action, user_id, sauna_id)
    
    if action == "create"
      Went.create(sauna_id: sauna_id, user_id: user_id)
    elsif action == "destroy"
      went = Went.find_by(sauna_id: sauna_id, user_id: user_id)
      went.destroy
    end

  end

end
