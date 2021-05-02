class SaunaWentWorker
  include Sidekiq::Worker

  def perform(action, user_id, sauna_id)
    
    if action == "create"
      unless Went.find_by(sauna_id: sauna_id, user_id: user_id).present?
        Went.create(sauna_id: sauna_id, user_id: user_id)
        puts "いきたい"
      else
        puts "いきたい済み"
      end
    elsif action == "destroy"
      went = Went.find_by(sauna_id: sauna_id, user_id: user_id)
      if went.present?
        went.destroy
        puts "いきたい取り消し"
      end
    end

  end

end
