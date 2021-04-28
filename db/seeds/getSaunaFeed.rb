@saunas = Sauna.all

@saunas.each do |sauna|
    begin 
        puts sauna.name_ja
        feed_url = Feedbag.find "#{sauna.hp}"
        unless feed_url.blank?
            sauna.feed = feed_url.first
            sauna.save
            puts feed_url.first
            puts "　追加！feed"
        else
            puts "　feedがないよ"
        end
    
    rescue => e 
        puts "●　なんかエラー"
    end
end