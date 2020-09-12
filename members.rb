class Members
  include Enumerable

  def initialize
    @members = []
  end

  def each
    @members.each { |member| yield member }
  end

  def add(member)
    @members << member
  end

  def remove(member)
    @members.delete(member)
  end

  def broadcast(message, sender)
    receivers = @members - [sender]
    receivers.each do |receiver|
      receiver.socket.puts("> #{sender.username}: #{message}")
    end
  end
  
  def register(socket)
    socket.print "Enter a username: "
      username = socket.gets.chomp
      member = Member.new(username, socket)
      member.welcome_from(self)
      add(member)
      broadcast("[joined]", member)
      member
  end

  def start_listening_to(member)
    loop do
      message = member.socket.readline
      broadcast(message, member)
    end
  end
  
  def disconnect(member)
    member.socket.close
    broadcast("[left]", member)
    remove(member)
  end
  
end
