require 'socket'

server = TCPServer.new(2000)

while true
  connection = server.accept

  connection.print "What's your name? "
  name = connection.gets.chomp
  connection.puts "Welcome, #{name}!"
  connection.close
end