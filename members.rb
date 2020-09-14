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
      receiver.socket.print("#{sender.username}: #{message}")
      receiver.newline_prompt
    end
  end
  
  def register(socket)
    username = get_member_info(socket)
    member = Member.new(username, socket)
    member.welcome_from(self)
    add(member)
    broadcast("[joined]", member)
    member
  end

  def start_listening_to(member)
    loop do
      message = member.listen
      broadcast(message, member)
      member.prompt
    end
  end
  
  def disconnect(member)
    broadcast("[left]", member)
    member.disconnect
    remove(member)
  end
  
  private

  def get_member_info(socket)
    socket.print "Enter a username: "
    username = socket.gets.chomp
  end
  
end
