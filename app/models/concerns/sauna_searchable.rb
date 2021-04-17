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
        end
      end
  
      # ③mappingの定義に合わせてindexするドキュメントの情報を生成する
      def as_indexed_json(*)
        attributes
        .symbolize_keys
        .slice(:name_ja, :address)
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

      def es_search(query)
        __elasticsearch__.search({
            "query": {
                "bool": {
                  "should": [
                    {
                        "term": {
                            "name_ja": query,
                        }
                    },
                    {
                        "term": {
                          "address": query
                        }
                    }
                  ]
                }
              },
              size: 300
        })
      end
    end
  end