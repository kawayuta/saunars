module SaunaSearchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
  
      # ①index名
      index_name "es_sauna_#{Rails.env}"
  
      # ②マッピング情報
      settings do
        mappings dynamic: 'false' do
          indexes :name_ja,             type: 'text', analyzer: 'kuromoji'
          indexes :address,                type: 'text', analyzer: 'kuromoji'
          indexes :price,                type: 'integer'
          indexes :latitude,                type: 'double'
          indexes :longitude,                type: 'double'
          indexes :location,                type: 'geo_point'
          
          indexes :loyly, type: 'text', term_vector: 'yes'
          indexes :auto_loyly, type: 'text', term_vector: 'yes'
          indexes :self_loyly, type: 'text', term_vector: 'yes'
          indexes :gaikiyoku, type: 'text', term_vector: 'yes'
          indexes :rest_space, type: 'text', term_vector: 'yes'
          indexes :free_time, type: 'text', term_vector: 'yes'
          indexes :capsule_hotel, type: 'text', term_vector: 'yes'
          indexes :in_rest_space, type: 'text', term_vector: 'yes'
          indexes :eat_space, type: 'text', term_vector: 'yes'
          indexes :wifi, type: 'text', term_vector: 'yes'
          indexes :power_source, type: 'text', term_vector: 'yes'
          indexes :work_space, type: 'text', term_vector: 'yes'
          indexes :manga, type: 'text', term_vector: 'yes'
          indexes :body_care, type: 'text', term_vector: 'yes'
          indexes :body_towel, type: 'text', term_vector: 'yes'
          indexes :water_dispenser, type: 'text', term_vector: 'yes'
          indexes :washlet, type: 'text', term_vector: 'yes'
          indexes :credit_settlement, type: 'text', term_vector: 'yes'
          indexes :parking_area, type: 'text', term_vector: 'yes'
          indexes :ganbanyoku, type: 'text', term_vector: 'yes'
          indexes :tattoo, type: 'text', term_vector: 'yes'

          indexes :shampoo, type: 'text', term_vector: 'yes'
          indexes :conditioner, type: 'text', term_vector: 'yes'
          indexes :body_soap, type: 'text', term_vector: 'yes'
          indexes :face_soap, type: 'text', term_vector: 'yes'
          indexes :razor, type: 'text', term_vector: 'yes'
          indexes :toothbrush, type: 'text', term_vector: 'yes'
          indexes :nylon_towel, type: 'text', term_vector: 'yes'
          indexes :hairdryer, type: 'text', term_vector: 'yes'
          indexes :face_towel_unlimited, type: 'text', term_vector: 'yes'
          indexes :bath_towel_unlimited, type: 'text', term_vector: 'yes'
          indexes :sauna_underpants_unlimited, type: 'text', term_vector: 'yes'
          indexes :sauna_mat_unlimited, type: 'text', term_vector: 'yes'
          indexes :flutterboard_unlimited, type: 'text', term_vector: 'yes'
          indexes :toner, type: 'text', term_vector: 'yes'
          indexes :emulsion, type: 'text', term_vector: 'yes'
          indexes :makeup_remover, type: 'text', term_vector: 'yes'
          indexes :cotton_swab, type: 'text', term_vector: 'yes'

        end
      end
  
      # ③mappingの定義に合わせてindexするドキュメントの情報を生成する
      def as_indexed_json(options={})
        # カテゴリについて
        sauna_attrs = {
          id: self.id,
          name_ja: self.name_ja,
          address: self.address,
          price: self.price,
          latitude: self.latitude,
          longitude: self.longitude,
          location: "#{self.latitude},#{self.longitude}",

          sauna_temperature: self.sauna_rooms.map(&:sauna_temperature),
          mizu_temperature: self.sauna_rooms.map(&:mizu_temperature),
          gender: self.sauna_rooms.map(&:gender),

          loyly: self.sauna_roles.map(&:loyly),
          auto_loyly: self.sauna_roles.map(&:auto_loyly),
          self_loyly: self.sauna_roles.map(&:self_loyly),
          gaikiyoku: self.sauna_roles.map(&:gaikiyoku),
          rest_space: self.sauna_roles.map(&:rest_space),
          free_time: self.sauna_roles.map(&:free_time),
          capsule_hotel: self.sauna_roles.map(&:capsule_hotel),
          in_rest_space: self.sauna_roles.map(&:in_rest_space),
          eat_space: self.sauna_roles.map(&:eat_space),
          wifi: self.sauna_roles.map(&:wifi),
          power_source: self.sauna_roles.map(&:power_source),
          work_space: self.sauna_roles.map(&:work_space),
          manga: self.sauna_roles.map(&:manga),
          body_care: self.sauna_roles.map(&:body_care),
          body_towel: self.sauna_roles.map(&:body_towel),
          water_dispenser: self.sauna_roles.map(&:water_dispenser),
          washlet: self.sauna_roles.map(&:washlet),
          credit_settlement: self.sauna_roles.map(&:credit_settlement),
          parking_area: self.sauna_roles.map(&:parking_area),
          ganbanyoku: self.sauna_roles.map(&:ganbanyoku),
          tattoo: self.sauna_roles.map(&:tattoo),

          shampoo: self.sauna_amenities.map(&:shampoo),
          conditioner: self.sauna_amenities.map(&:conditioner),
          body_soap: self.sauna_amenities.map(&:body_soap),
          face_soap: self.sauna_amenities.map(&:face_soap),
          razor: self.sauna_amenities.map(&:razor),
          toothbrush: self.sauna_amenities.map(&:toothbrush),
          nylon_towel: self.sauna_amenities.map(&:nylon_towel),
          hairdryer: self.sauna_amenities.map(&:hairdryer),
          face_towel_unlimited: self.sauna_amenities.map(&:face_towel_unlimited),
          bath_towel_unlimited: self.sauna_amenities.map(&:bath_towel_unlimited),
          sauna_underpants_unlimited: self.sauna_amenities.map(&:sauna_underpants_unlimited),
          sauna_mat_unlimited: self.sauna_amenities.map(&:sauna_mat_unlimited),
          flutterboard_unlimited: self.sauna_amenities.map(&:flutterboard_unlimited),
          toner: self.sauna_amenities.map(&:toner),
          emulsion: self.sauna_amenities.map(&:emulsion),
          makeup_remover: self.sauna_amenities.map(&:makeup_remover),
          cotton_swab: self.sauna_amenities.map(&:cotton_swab)
        }

        # # カテゴリに紐づく記事について
        # sauna_attrs[:sauna_roles] = self.sauna_roles.map do |role|
        #   {
        #     id: role.id,
        #     loyly: role.loyly.to_s,
        #     self_loyly: role.self_loyly.to_s
        #   }
        # end

        sauna_attrs.as_json
      end
    end
  
    class_methods do
      # ④indexを作成するメソッド
      def create_index!
        client = __elasticsearch__.client
        # すでにindexを作成済みの場合は削除する
        client.indices.delete index: self.index_name rescue nil
        # indexを作成する
        client.indices.create(index: self.index_name,
                              body: {
                                  settings: self.settings.to_hash,
                                  mappings: self.mappings.to_hash
                              })
      end


      def es_recommend_currentLocation_search(wents, lat, lon)
        __elasticsearch__.search({
          "query": {
            "bool": {
              "filter": {
                        "geo_distance": {
                            "distance": "#{50}km",
                            "location": {
                                "lat": lat,
                                "lon": lon
                            }
                        }
                },
              "must": [
                {
                  "more_like_this": {
                        "fields": [
                          "sauna_temperature",
                          "mizu_temperature",
                          "gender",
      
                          "loyly",
                          "auto_loyly",
                          "self_loyly",
                          "gaikiyoku",
                          "rest_space",
                          "free_time",
                          "capsule_hotel",
                          "in_rest_space",
                          "eat_space",
                          "wifi",
                          "power_source",
                          "work_space",
                          "manga",
                          "body_care",
                          "body_towel",
                          "water_dispenser",
                          "washlet",
                          "credit_settlement",
                          "parking_area",
                          "ganbanyoku",
                          "tattoo",
      
                          "shampoo",
                          "conditioner",
                          "body_soap",
                          "face_soap",
                          "razor",
                          "toothbrush",
                          "nylon_towel",
                          "hairdryer",
                          "face_towel_unlimited",
                          "bath_towel_unlimited",
                          "sauna_underpants_unlimited",
                          "sauna_mat_unlimited",
                          "flutterboard_unlimited",
                          "toner",
                          "emulsion",
                          "makeup_remover",
                          "cotton_swab",
                        ],
                        "like": [
                          {
                            "_id": wents[0],
                            "_id": wents[1],
                            "_id": wents[2],
                            "_id": wents[3],
                            "_id": wents[4],
                          }
                        ],
                        "min_term_freq": 1,
                        "max_query_terms": 12
                  }
                }
              ]
            }
          },
          "size": 30
        })
      end


      def es_recommend_search(wents)
        __elasticsearch__.search({
          "query": {
            "more_like_this": {
                  "fields": [
                    "sauna_temperature",
                    "mizu_temperature",
                    "gender",

                    "loyly",
                    "auto_loyly",
                    "self_loyly",
                    "gaikiyoku",
                    "rest_space",
                    "free_time",
                    "capsule_hotel",
                    "in_rest_space",
                    "eat_space",
                    "wifi",
                    "power_source",
                    "work_space",
                    "manga",
                    "body_care",
                    "body_towel",
                    "water_dispenser",
                    "washlet",
                    "credit_settlement",
                    "parking_area",
                    "ganbanyoku",
                    "tattoo",

                    "shampoo",
                    "conditioner",
                    "body_soap",
                    "face_soap",
                    "razor",
                    "toothbrush",
                    "nylon_towel",
                    "hairdryer",
                    "face_towel_unlimited",
                    "bath_towel_unlimited",
                    "sauna_underpants_unlimited",
                    "sauna_mat_unlimited",
                    "flutterboard_unlimited",
                    "toner",
                    "emulsion",
                    "makeup_remover",
                    "cotton_swab",
                  ],
                  "like": [
                    {
                      "_id": wents[0],
                      "_id": wents[1],
                      "_id": wents[2],
                      "_id": wents[3],
                      "_id": wents[4],
                    }
                  ],
                  "min_term_freq": 1,
                  "max_query_terms": 12
                }
          },
          "size": 30
        })
      end

      def es_incremental_search(query, lat, lon, radius, currentLatitude, currentLongitude, sortType)
        __elasticsearch__.search({
        "query": {
          "function_score": {
            "query": { "match_all": {} },
            "boost": 1, 
            "functions": [
              {
                "filter": { "match": { "name_ja": query } },
                "weight": 3
              },
              {
                "filter": { "match": { "address": query } },
                "weight": 3
              },
              {
                "filter": {
                        "geo_distance": {
                            "distance": "#{radius}km",
                            "location": {
                                "lat": lat,
                                "lon": lon
                            }
                        }
                },
                "weight": 2
              }
            ],
            "max_boost": 5,
            "score_mode": "max",
            "boost_mode": "multiply",
            "min_score": 2
          }
        },
        "sort": [
          "_score",
          {
            "_geo_distance": {
              "location": {
                "lat": currentLatitude,
                "lon": currentLongitude,
              },
              "order": 'desc',
              "unit": 'meters',
            }
          },
        ],
        "size": 300
        })
      end


      def es_price_search(query, lat, lon, radius, sortType)
        __elasticsearch__.search({
        "query": {
          "function_score": {
            "query": { "match_all": {} },
            "boost": 1, 
            "functions": [
              {
                "filter": { "match": { "name_ja": query } },
                "weight": 3
              },
              {
                "filter": { "match": { "address": query } },
                "weight": 3
              },
              {
                "filter": {
                        "geo_distance": {
                            "distance": "#{radius}km",
                            "location": {
                                "lat": lat,
                                "lon": lon
                            }
                        }
                },
                "weight": 2
              }
            ],
            "max_boost": 5,
            "score_mode": "max",
            "boost_mode": "multiply",
            "min_score": 2
          }
        },
        "sort": [
          "_score",
          {
            "price": {
              "order": (sortType == "1" ? "asc" : "desc"),
            }
          },
        ],
        "size": 200
        })
      end

      def es_currentLocation_search(query, lat, lon, radius, currentLatitude, currentLongitude, sortType)
        __elasticsearch__.search({
        "query": {
          "function_score": {
            "query": { "match_all": {} },
            "boost": 1, 
            "functions": [
              {
                "filter": { "match": { "name_ja": query } },
                "weight": 3
              },
              {
                "filter": { "match": { "address": query } },
                "weight": 3
              },
              {
                "filter": {
                        "geo_distance": {
                            "distance": "#{radius}km",
                            "location": {
                                "lat": lat,
                                "lon": lon
                            }
                        }
                },
                "weight": 2
              }
            ],
            "max_boost": 5,
            "score_mode": "max",
            "boost_mode": "multiply",
            "min_score": 2
          }
        },
        "sort": [
          "_score",
          {
            "_geo_distance": {
              "location": {
                "lat": currentLatitude,
                "lon": currentLongitude,
              },
              "order": 'desc',
              "unit": 'meters',
            }
          },
        ],
        "size": 200
        })
      end

      def es_search(query, lat, lon, radius)
        __elasticsearch__.search({
        "query": {
          "function_score": {
            "query": { "match_all": {} },
            "boost": 1, 
            "functions": [
              {
                "filter": { "match": { "name_ja": query } },
                "weight": 3
              },
              {
                "filter": { "match": { "address": query } },
                "weight": 3
              },
              {
                "filter": {
                        "geo_distance": {
                            "distance": "#{radius}km",
                            "location": {
                                "lat": lat,
                                "lon": lon
                            }
                        }
                },
                "weight": 2
              }
            ],
            "max_boost": 5,
            "score_mode": "max",
            "boost_mode": "multiply",
            "min_score": 2
          }
        },
        "sort": [
          "_score",
          {
            "_geo_distance": {
              "location": {
                "lat": lat,
                "lon": lon,
              },
              "order": 'asc',
              "unit": 'meters',
            }
          },
        ],
        "size": 200
        })
      end

      private

      def calc_distance_script(lat, lon)
        { distance: {
            params: {
              latitude: lat,
              longitude: lon,
            },
            script: "doc['location'].distance(lat,lon)", # 点[lat, lon] からの距離をメートル単位で算出
          }
        }
      end
      
      
    end
  end