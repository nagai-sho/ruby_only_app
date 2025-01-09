require 'socket'

server = TCPServer.new(2000)

loop do
  client = server.accept
  request = client.gets

  # HTTPレスポンスを構築
response = "HTTP/1.1 200 OK\r\n"
  response += "Content-Type: text/html\r\n"
  response += "\r\n"
  response += "<html><body><h1>Hello, Ruby!</h1></body></html>"

  client.print response
  client.close
end