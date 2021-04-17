@saunas = Sauna.all

@saunas.each do |sauna|
    sauna.address = sauna.address
    sauna.save

    puts sauna.latitude
end