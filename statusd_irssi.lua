socket = require"socket"
socket.unix = require"socket.unix"

local home=os.getenv("HOME")
home=(home and home.."/" or "")

local defaults = {
   update_interval = 3*1000,
   irssi_dir = home .. ".rssi/",
   irssi_socket = home .. ".irssi/socket"
}

local settings = table.join(statusd.get_config("irssi"), defaults)

function update_irssi()
   c = assert(socket.unix())
   assert(c:connect(settings.irssi_socket))
   result, err, nsent = c:send("activity\n")
   result, err = c:receive("*a")
   c:close()
   text = ""
   msg = ""
   hl = ""
   for i = 1, result:len(), 4 do
      win = result:sub(i, i+1)
      level = tonumber(result:sub(i+1, i+2))
      if level == 1 then
	 text = text .. win
      elseif level == 2 then
	 msg = msg .. win
      elseif level == 3 then
	 hl = hl .. win
      end
   end
   statusd.inform("irssi_text", text)
   statusd.inform("irssi_msg", msg)
   statusd.inform("irssi_msg_hint", "important")
   statusd.inform("irssi_hl", hl)
   statusd.inform("irssi_hl_hint", "critical")
   irssi_timer:set(settings.update_interval, update_irssi)
end

irssi_timer = statusd.create_timer()
update_irssi()
