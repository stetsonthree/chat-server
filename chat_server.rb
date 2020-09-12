require 'socket'
require './members'
require './member'

server = TCPServer.new(2000)

puts "Server running on port 2000..."

members = Members.new

while true
  tcp_socket = server.accept
  Thread.new(tcp_socket) do |socket|
    socket.print "Enter a username: "
    username = socket.gets.chomp
    member = Member.new(username, socket)
    member.welcome_from(members)
    members.add(member)
    members.broadcast("[joined]", member)
    # socket.close
  end
end
