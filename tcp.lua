
-- server listens on 80, if data received, print data to console and send "hello world" back to caller
-- 30s time out for a inactive client
srv = net.createServer(net.TCP, 0)

function receiver(sck, data)
  local response = {}

  response[#response + 1] = "response from esp\n"

  -- if you're sending back HTML over HTTP you'll want something like this instead
  -- local response = {"HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nContent-Type: text/html\r\n\r\n"}

  -- sends and removes the first element from the 'response' table
  local function send(localSocket)
    if #response > 0 then
    --print(response)
      localSocket:send(table.remove(response, 1))
    else
      localSocket:close()
      response = nil
    end
  end

  -- triggers the send() function again once the first chunk of data was sent
  sck:on("sent", send)
  send(sck)
end

--if srv then
--  srv:listen(80, function(conn)
--    conn:on("receive", receiver)
--  end)
--end

--if srv then
    srv:listen(80, function(conn)
--        conn:on("receive", function(sck, c) print(c) end)
        conn:on("connection", function(sck, c)
            sck:send("poop\n")
        end)
    end)
--end
