#!/usr/bin/lua
local devurandom = io.open("/dev/urandom","rb")
local b1,b2 = devurandom:read(2):byte(1,2)
local autoupdaterlockfile='/var/lock/autoupdater.lock'
local directorurl='http://api.ff3l/move/'
local geoapiurl='http://api.ff3l/getdombycoord/'
seed = b1 + (256 * b2)
math.randomseed(seed)
local delay = math.random(60)
function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end
local uci=require('simple-uci').cursor()
local o=uci:get('gluon','core','ignorerelocate')
if (o=='1') then
  io.write("Ignoring Domain Change request.. Exiting.\n")
  do return end
end
io.write('Sleeping for ' .. delay .. ' Seconds.\n')
os.execute('sleep ' .. delay)
local currentdomain=uci:get("gluon","core","domain")
local nodeid = require('gluon.util').node_id()
local lat = uci:get("gluon-node-info","@location[0]","latitude")
local lon = uci:get("gluon-node-info","@location[0]","longitude")
local url=geoapiurl .. lat .. "," .. lon
local geoseg = io.popen("wget -q -O - '" .. url .. "'"):read('*a')
local url=directorurl .. nodeid
local manseg = io.popen("wget -q -O - '" .. url .. "'"):read('*a')
io.write('Current Domain: ' .. currentdomain .. '\nNodeID: ' .. nodeid .. '\nRequested Domain: ' .. manseg .. '\nDomain by Coordinates: ' .. geoseg .. '\n')
if (manseg ~= "" or currentdomain=="ref" ) then
  newseg = manseg
elseif (uci:get('gluon','core','noautodomain') ~= "1") then
  newseg = geoseg
end

if (currentdomain==newseg or newseg == "" or newseg == nil or newseg == "noop") then
  io.write("Do nothing..\n")
else
  if (file_exists('/lib/gluon/domains/' .. newseg .. '.json') == true) then
    -- This is not nice, but it works. nixio lacks flock...
    local alock = io.popen('lock -n ' .. autoupdaterlockfile .. ' 2>/dev/null && echo unlocked || echo locked'):read('*l')
    if (alock ~= 'unlocked') then
      io.write('Detected Flock on ' .. autoupdaterlockfile .. '. Exiting.\n')
      do return end
    end
    os.execute('logger -s -t "gluon-segment-mover" -p 5 "Domain Change requested. Moving to "' .. newseg)
    uci:set('gluon','core','domain',newseg)
    uci:save('gluon')
    uci:commit('gluon')
    os.execute('/usr/bin/gluon-reconfigure')
    io.popen('lock -u ' .. autoupdaterlockfile)
    io.popen('reboot')
  else
    io.write('Invalid Domain requested. I don\'t have ' .. newseg .. '.conf')
    do return end
  end
end
