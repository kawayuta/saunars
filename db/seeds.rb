# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'open-uri'
require 'nokogiri'
require "mini_magick"
count = 1

loop do

    url = "https://sauna-ikitai.com/search?page=#{count}"
    charset = nil
    html = open(url) do |f|
    charset = f.charset
    f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)


    doc.search('.p-saunaItem--list').each do |item|
        name = item.search('h3').text.gsub(/(\r\n?|\n)/,"").strip
        address = item.search(".p-saunaItem_address").text.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z').gsub(/(\r\n?|\n)/,"").strip
       
        # man
        sauna_temperature_man = item.search('.p-saunaItemSpec_content--man .p-saunaItemSpec_item--sauna span').text.gsub('℃',"")
        mizu_temperature_man = item.search('.p-saunaItemSpec_content--man .p-saunaItemSpec_item--mizuburo span').text.gsub('℃',"")
       
        # woman
        sauna_temperature_woman = item.search('.p-saunaItemSpec_content--woman .p-saunaItemSpec_item--sauna span').text.gsub('℃',"")
        mizu_temperature_woman = item.search('.p-saunaItemSpec_content--woman .p-saunaItemSpec_item--mizuburo span').text.gsub('℃',"")
       
        price = item.search('.p-saunaItem_informations li')[0].text.gsub(/[^\d]/, "").to_i
        holiday = item.search('.p-saunaItem_informations li')[1].text.split('：')[1].to_s.chomp

        

        #sauna_info
        item_href = item.search('a').attribute('href').value
        charset = nil
        html = open(item_href) do |f|
        charset = f.charset
        f.read
        end
        info_doc = Nokogiri::HTML.parse(html, nil, charset)

        type = info_doc.search('.p-saunaDetailShop_info tr td')[1].text.gsub(/(\r\n?|\n)/,"").strip
        parking = info_doc.search('.p-saunaDetailShop_info tr td')[4].text.gsub(/(\r\n?|\n)/,"").strip
        tel = info_doc.search('.p-saunaDetailShop_info tr td')[5].text.gsub(/(\r\n?|\n)/,"").strip
        hp = info_doc.search('.p-saunaDetailShop_info tr td')[6].text.gsub(/(\r\n?|\n)/,"").strip

        tags = info_doc.search('.p-tags_tag')

        #setubi

        loyly = info_doc.search('.p-saunaSpecTable tr')[0].search('img').attribute('alt').to_s == "有り" ? true : false
        auto_loyly = info_doc.search('.p-saunaSpecTable tr')[1].search('img').attribute('alt').to_s == "有り" ? true : false
        self_loyly = info_doc.search('.p-saunaSpecTable tr')[2].search('img').attribute('alt').to_s == "有り" ? true : false
        gaikiyoku = info_doc.search('.p-saunaSpecTable tr')[3].search('img').attribute('alt').to_s == "有り" ? true : false
        rest_space = info_doc.search('.p-saunaSpecTable tr')[4].search('img').attribute('alt').to_s == "有り" ? true : false
        
        free_time = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[0].text.to_s == "○" ? true : false
        capsule_hotel = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[1].text.to_s == "○" ? true : false
        in_rest_space = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[2].text.to_s == "○" ? true : false
        eat_space = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[3].text.to_s == "○" ? true : false
        wifi = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[4].text.to_s == "○" ? true : false
        power_source = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[5].text.to_s == "○" ? true : false
        work_space = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[6].text.to_s == "○" ? true : false
        manga = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[7].text.to_s == "○" ? true : false
        body_care = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[8].text.to_s == "○" ? true : false
        body_towel = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[9].text.to_s == "○" ? true : false
        water_dispenser = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[10].text.to_s == "○" ? true : false
        washlet = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[11].text.to_s == "○" ? true : false
        credit_settlement = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[12].text.to_s == "○" ? true : false
        parking_area = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[13].text.to_s == "○" ? true : false
        ganbanyoku = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[14].text.to_s == "○" ? true : false
        tattoo = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[15].text.to_s == "○" ? true : false

        # puts free_time
        # puts capsule_hotel
        # puts in_rest_space
        # puts eat_space
        # puts wifi
        # puts power_source
        # puts work_space
        # puts manga
        # puts body_care
        # puts body_towel
        # puts water_dispenser
        # puts washlet
        # puts credit_settlement
        # puts parking_area
        # puts ganbanyoku
        # puts tattoo


        #amenity
        shampoo = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[16].text.to_s == "○" ? true : false
        conditioner = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[17].text.to_s == "○" ? true : false
        body_soap = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[18].text.to_s == "○" ? true : false
        face_soap = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[19].text.to_s == "○" ? true : false
        razor = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[20].text.to_s == "○" ? true : false
        toothbrush = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[21].text.to_s == "○" ? true : false
        nylon_towel = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[22].text.to_s == "○" ? true : false
        hairdryer = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[23].text.to_s == "○" ? true : false
        face_towel_unlimited = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[24].text.to_s == "○" ? true : false
        bath_towel_unlimited = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[25].text.to_s == "○" ? true : false
        sauna_underpants_unlimited = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[26].text.to_s == "○" ? true : false
        sauna_mat_unlimited = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[27].text.to_s == "○" ? true : false
        flutterboard_unlimited = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[28].text.to_s == "○" ? true : false
        toner = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[29].text.to_s == "○" ? true : false
        emulsion = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[30].text.to_s == "○" ? true : false
        makeup_remover = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[31].text.to_s == "○" ? true : false
        cotton_swab = info_doc.search('.p-saunaSpecList li .p-saunaSpecList_value')[32].text.to_s == "○" ? true : false

        
        # puts shampoo
        # puts conditioner
        
        # puts body_soap
        # puts face_soap
        # puts razor
        # puts toothbrush
        # puts nylon_towel

        # puts hairdryer
        # puts face_towel_unlimited
        # puts bath_towel_unlimited
        # puts sauna_underpants_unlimited
        # puts sauna_mat_unlimited

        # puts flutterboard_unlimited
        # puts toner
        # puts emulsion
        # puts makeup_remover
        # puts cotton_swab


        # p type
        # p parking
        # p tel
        # p hp

        #  p name
        #  p address
        #  p price
        #  p holiday

        #  p sauna_temperature_man
        #  p mizu_temperature_man
        #  p gaiki_temperature_man
        #  p loyly_temperature_man
        
        #  p sauna_temperature_woman
        #  p mizu_temperature_woman
        #  p gaiki_temperature_woman
        #  p loyly_temperature_woman
       
       gender = if !sauna_temperature_woman.empty? && !sauna_temperature_man.empty?
                    0
                    #man & woman
               elsif sauna_temperature_woman.empty? && !sauna_temperature_man.empty?
                    1
                    #mans only
               elsif !sauna_temperature_woman.empty? && sauna_temperature_man.empty?
                    2
                    #woman only
               else
                    3
                    #other
               end

        unless Sauna.where(name_ja: name).present?
        @sauna = Sauna.new
        @sauna.name_ja = name
        @sauna.address = address
        @sauna.gender = gender
        @sauna.holiday = holiday
        @sauna.price = price
        @sauna.tel = tel
        @sauna.hp = hp
        @sauna.parking = parking
        if @sauna.save
            image_url = item.search('.p-saunaItem_image img').attribute('src')
            file = MiniMagick::Image.open(image_url)
            @sauna.image = file
            @sauna.save
            # save_to_local = file.write  "public/sauna_images/#{@sauna.id}.jpg"
            # save_to_local = file.write  "public/sauna_images/state/#{@sauna.id}.jpg"
        end

        @role = @sauna.sauna_roles.new
        @role.loyly = loyly
        @role.auto_loyly = auto_loyly
        @role.self_loyly = self_loyly
        @role.gaikiyoku = gaikiyoku
        @role.rest_space = rest_space
        @role.free_time = free_time
        @role.capsule_hotel = capsule_hotel
        @role.in_rest_space = in_rest_space
        @role.eat_space = eat_space
        @role.wifi = wifi
        @role.power_source = power_source
        @role.work_space = work_space
        @role.manga = manga
        @role.body_care = body_care
        @role.body_towel = body_towel
        @role.water_dispenser = water_dispenser
        @role.washlet = washlet
        @role.credit_settlement = credit_settlement
        @role.parking_area = parking_area
        @role.ganbanyoku = ganbanyoku
        @role.tattoo = tattoo
        @role.save


        @amenities = @sauna.sauna_amenities.new
        @amenities.shampoo = shampoo
        @amenities.conditioner = conditioner
        @amenities.body_soap = body_soap
        @amenities.face_soap = face_soap
        @amenities.razor = razor
        @amenities.toothbrush = toothbrush
        @amenities.nylon_towel = nylon_towel
        @amenities.hairdryer = hairdryer
        @amenities.face_towel_unlimited = face_towel_unlimited
        @amenities.bath_towel_unlimited = bath_towel_unlimited
        @amenities.sauna_underpants_unlimited = sauna_underpants_unlimited
        @amenities.sauna_mat_unlimited = sauna_mat_unlimited
        @amenities.flutterboard_unlimited = flutterboard_unlimited
        @amenities.toner = toner
        @amenities.emulsion = emulsion
        @amenities.makeup_remover = makeup_remover
        @amenities.cotton_swab = cotton_swab
        @amenities.save


        if !sauna_temperature_woman.empty?
            @sauna_room_woman = @sauna.sauna_rooms.new
            @sauna_room_woman.sauna_temperature = sauna_temperature_woman
            @sauna_room_woman.mizu_temperature = mizu_temperature_woman
            @sauna_room_woman.gender = 1
            # 1 == woman (Room)
            @sauna_room_woman.save
        end


        if !sauna_temperature_man.empty?
            @sauna_room_man = @sauna.sauna_rooms.new
            @sauna_room_man.sauna_temperature = sauna_temperature_man
            @sauna_room_man.mizu_temperature = mizu_temperature_man
            @sauna_room_man.gender = 0
            # 0 == man (Room)
            @sauna_room_man.save
        end


        tags.each { |item| 
            title = item.text.gsub(/(\r\n?|\n)/,"").strip
            if @sauna.sauna_tags.find_by(title: title).blank?
                @sauna_tag = @sauna.sauna_tags.new
                @sauna_tag.title = title
                @sauna_tag.save
            end
        }
        puts "追加した"
    else 
        puts "ある"
    end

    end

    count += 1
end

