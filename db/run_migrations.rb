Dir['db/migrations/*.rb'].sort.each do |file|
  puts "Running #{file}..."
  require_relative "../#{file}"
  
  up()
end
