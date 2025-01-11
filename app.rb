require 'socket'
# TCP/IP通信を行うためのクラス（TCPServerやTCPSocketなど）

server = TCPServer.new(2000)
# ポート番号2000で新しいTCPサーバーを作成する
# TCPServer.newメソッドは、指定したポートで接続要求を待ち受けるサーバーインスタンスを返す

# loop do で無限ループを開始
# このループ内で、クライアントからの接続を待ち受け、処理を行う
# 無限ループにすることで、サーバーが常に動作し続けることが可能
loop do
  client = server.accept
  # acceptメソッド : 接続が確立されると新しいTCPSocketインスタンス（ここではclient）を返す
  # → クライアントからの接続を受け入れる
  request = client.gets
  # クライアントから送信されたリクエストデータを1行読み取る
  request_path = request.split[1]

  content = case request_path
  when "/"
    File.read(File.join("views", "top.html"))
  when "/index"
    File.read(File.join("views", "index.html"))
  when "/edit"
    File.read(File.join("views", "edit.html"))
  when "/show"
    File.read(File.join("views", "show.html"))
  else
    "<html><body><h1>404 Not Found</h1></body></html>"
  end

  # HTTPレスポンスを構築
  response = "HTTP/1.1 200 OK\r\n"
  response += "Content-Type: text/html\r\n"
  response += "\r\n"
  response += content

  client.print response
  client.close
end