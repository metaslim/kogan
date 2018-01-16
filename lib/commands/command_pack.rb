Dir[File.dirname(__FILE__) + '/*.rb'].each do |file|
  require file if file != /(base|command_pack)\.rb/
end
