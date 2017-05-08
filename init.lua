-- List of files to use
local wifiAP_file = "wifiAP.lua"
local uart_file = "uart.lua"

local abortFlag = false    -- Keep track of abort choice
local abortTimeout = 4000  -- user timer in ms
local bootTimeout = 200    -- slight pause before starting init

-- Print firmware version (float or integer)
function firmwareInfo()
    -- check if float version is being used
    -- by doing floating point arithmetic 
    if (1/3) > 0 then
        print('FLOAT firmware version')
    else
        print('INTEGER firmware version')
    end
end

-- Start uart listener and timer
function init()
    print("Press ENTER to abort startup")

    -- Listen through uart for return key
    -- call abort() if pressed
    uart.on('data', '\r', abort, 0)

    -- This is the 3 second abort timer
    tmr.alarm(0, abortTimeout, 0, startup)
end

-- Abort the bootup
function abort()
    abortFlag = true
end

-- Check if the file exists on flash
function fileExists(name)
    -- Get lua table of files {name:size}
    local l = file.list()

    -- Loop through key:value pairs
    -- If file found return true
    for k,v in pairs(l) do
        if k == name then
            return true
        end
    end
    return false
end

-- Check if file has been loaded 
-- onto memory before running
function runFile(filename)

    if fileExists(filename) then
        dofile(filename)
    else
        print('Start script '..filename..' not found')
    end
end

-- Start the boot process
function startup()
    -- turn off uart scanning
    uart.on('data')

    -- Abort
    if abortFlag == true then
        print(' ### Startup Aborted ###')
        return
    end

    runFile("wifiAP.lua")
    runFile("uart.lua")
--    runFile("tcp.lua")

end

-- print firmware version
firmwareInfo()

-- Run the init function
tmr.alarm(0, bootTimeout, 0, init)
