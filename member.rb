class Member
  attr_reader :username, :socket

  def initialize(username, socket)
    @username = username
    @socket = socket
  end

  def welcome_from(members)
    socket.puts "Welcome, #{username}! There are #{members.count} people here."
  end
end
