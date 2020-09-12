require 'socket'
require './members'
require './member'

server = TCPServer.new(2000)

puts "Server running on port 2000..."

members = Members.new

while true
  tcp_socket = server.accept
  Thread.new(tcp_socket) do |socket|
    member = members.register(socket)
    begin
      members.start_listening_to(member)
    rescue EOFError
      members.disconnect(member)
    end
  end
end
