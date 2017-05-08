srv = net.createServer(net.TCP, 0)  -- Create tcp server

-- Run the uart and send data over tcp upon correct completion
function runUart(sck)
    print("listening on serial...")
    
    -- Read 16 bytes of data
    uart.on("data",16,
        function(data)
            -- Get terminating character '\r' of data sequence
            terminatingChar = string.sub(data, 16)
--            serialData = string.sub(data, 0, 15)
--            print("serial Data:", serialData)  -- debug

            -- Look for terminating character of sequence
            if terminatingChar == '\r' then
                print("It worked!")  -- Debug
                sck:send(data)  -- Send data through tcp
                uart.on("data")  -- debugging, stop callback of this function                
            end
    end,0)
end

-- Integrity checking
if srv then
    -- Wait for tcp client response
    srv:listen(80, function(conn)
        print("tcp connected")  -- Degubbing

        -- When connection is established run uart function
        conn:on("connection", runUart)  
    end)
end