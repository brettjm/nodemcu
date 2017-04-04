print("warming up wifi")

local str=wifi.ap.getmac();
local ssidTemp=string.format("%s%s%s",string.sub(str,10,11),string.sub(str,13,14),string.sub(str,16,17));

cfg={}
cfg.ssid="ESP_"..ssidTemp;
cfg.pwd="12345678"
wifi.ap.config(cfg)

cfg={}
cfg.ip="192.168.1.1";
cfg.netmask="255.255.255.0";
cfg.gateway="192.168.1.1";
wifi.ap.setip(cfg);
wifi.setmode(wifi.SOFTAP)

str=nil;
ssidTemp=nil;
collectgarbage();

print("soft AP started")
print("Heep:(bytes)"..node.heap());
print("MAC:"..wifi.ap.getmac().."\r\nIP:"..wifi.ap.getip());
