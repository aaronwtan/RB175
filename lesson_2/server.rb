require "socket"

def parse_request(request_line)
  http_method, path_and_params, http_version = request_line.split
  path, query = path_and_params.split('?')

  unless query.nil?
    param_pairs = query.split('&')
    params = param_pairs.map { |pair| pair.split('=') }.to_h
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/plain\r\n\r\n"
  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params

  unless params.nil?
    rolls = params['rolls'].to_i
    sides = params['sides'].to_i

    rolls.times do
      roll = rand(sides) + 1
      client.puts roll
    end
  end

  client.close
end
