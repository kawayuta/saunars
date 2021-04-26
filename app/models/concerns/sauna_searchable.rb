module SaunaSearchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
  
      # ①index名
      index_name "es_sauna_#{Rails.env}"
  
      settings index: {
        analysis: {
          filter: {
            pos_filter: {type: "kuromoji_part_of_speech", stoptags: ["助詞-格助詞-一般", "助詞-終助詞"]},
            greek_lowercase_filter: {type: "lowercase", language: "greek"}},
          analyzer: {
            kuromoji_analyzer: {
              type: "custom",
              tokenizer: "kuromoji_tokenizer",
              filter: ["kuromoji_baseform", "pos_filter", "greek_lowercase_filter", "cjk_width"]}}
          }} do
        mapping do
          indexes :name_ja,             type: 'text', analyzer: 'kuromoji'
          indexes :address,                type: 'text', analyzer: 'kuromoji'
          indexes :price,                type: 'integer'
          indexes :latitude,                type: 'double'
          indexes :longitude,                type: 'double'
          indexes :location,                type: 'geo_point'
        end
      end
      # ②マッピング情報
      # settings do
      #   mappings dynamic: 'false' do
      #     indexes :name_ja,             type: 'text', analyzer: 'kuromoji'
      #     indexes :address,                type: 'text', analyzer: 'kuromoji'
      #     indexes :price,                type: 'integer'
      #     indexes :latitude,                type: 'double'
      #     indexes :longitude,                type: 'double'
      #     indexes :location,                type: 'geo_point'
      #   end
      # end
  
      # ③mappingの定義に合わせてindexするドキュメントの情報を生成する
      def as_indexed_json(*)
        attributes
        .symbolize_keys
        .slice(:name_ja, :address, :latitude, :longitude, :price)
        .merge(location: "#{latitude},#{longitude}")
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
        "size": 30
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