local serialData = nil

print("listening on serial...")

uart.on("data","~",
    function(data)
        -- write response through tx
        print("writing response")
        uart.write(0, "~")
        
        -- listen for data word
        uart.on("data",2,
            function(data)
                serialData = data
                print("serial Data:")
                print(serialData)
                uart.on("data")  -- stop callback of this function                
        end,0)
    uart.on("data")  -- stop callback of this function
end,0)

