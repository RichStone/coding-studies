# Load the whole app into IRB when launching: `$ irb -r ./init.rb`
Dir[File.join(__dir__, 'app', '*.rb')].each { |file| require file }
@g = Gamemaster.new
