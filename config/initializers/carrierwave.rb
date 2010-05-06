CarrierWave.configure do |config|
  config.grid_fs_database = "mysnaplog"
  config.grid_fs_host = 'localhost'
  config.grid_fs_access_url = "/data"
  config.storage = :grid_fs
end
