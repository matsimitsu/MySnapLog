CarrierWave.configure do |config|
  config.grid_fs_database = "mysnaplog_#{Rails.env}"
  config.grid_fs_host = 'localhost'
  config.grid_fs_access_url = "/gridfs"
  config.storage = :grid_fs
end
