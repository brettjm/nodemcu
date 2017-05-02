print("listening on serial...")
 
-- listen for data word
uart.on("data",16,
    function(data)
        serialData = string.sub(data, 16)
        print("serial Data:", data)
        print("char:", serialData)
        if serialData == '\r' then
            print("It worked!")
            uart.on("data")  -- stop callback of this function                
        end
end,0)
