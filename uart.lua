srv = net.createServer(net.TCP, 0)  -- Create tcp server

-- Run the uart and send data over tcp upon correct completion
function runUart(sck)
    print("listening on serial...")
    
    -- Read 16 bytes of data
    uart.on("data",16,
        function(data)
            -- Get terminating character '\r' of data sequence
            terminatingChar = string.sub(data, 16)

            -- Get serial data and concatenate with newline char
            serialData = string.sub(data, 0, 15) .. '\n'
            print("serial Data:", serialData)  -- debug

            -- Look for terminating character of sequence
            if terminatingChar == '\r' then
                sck:send(serialData)  -- Send data through tcp
--                uart.on("data")  -- Stop callback of this function                
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