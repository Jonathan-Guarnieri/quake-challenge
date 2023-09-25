Dir['db/migrations/*.rb'].sort.each do |file|
  p "Running #{file}"
  require_relative "../#{file}"
  
  up()
end
