unless Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
        config.storage :fog
        config.fog_provider = 'fog/aws'
        config.fog_directory  = 'matsubishi-sample' # バケット名
        config.fog_public = false
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: 'AKIAWMVBD2J67SSYXGTU',
        aws_secret_access_key: '+yezVI72nOAlIGaw+c64tais9NV6GGGYwdXsrzaJ',
        region: 'ap-northeast-1', # リージョン
        path_style: true
      }
  
      config.fog_directory  = 'sauna-image'
      config.cache_storage = :fog
    end


  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  end