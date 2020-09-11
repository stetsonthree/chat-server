require 'socket'

server = TCPServer.new(2000)

puts "Server running on port 2000..."

while true
  tcp_socket = server.accept
  Thread.new(tcp_socket) do |socket|
    socket.print "What's your name? "
    name = socket.gets.chomp
    socket.puts "Welcome, #{name}!"
    socket.close
  end

end