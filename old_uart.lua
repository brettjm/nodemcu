ledOn = 0
pin = 4
gpio.mode(pin,gpio.OUTPUT)

print("listening on serial...")

uart.on("data",1,
    function(data)
        print("Receiving on uart:", data)  -- debugging
        if data=="~" then
            print("INITIATE")
            gpio.write(pin, gpio.HIGH)
        elseif data=="." then
            print("LED OFF")
            gpio.write(pin, gpio.LOW)
        end
    end,0)