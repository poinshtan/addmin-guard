        
--Begin Fun.lua By @MeGaPlusTeaM
--Special Thx To @SajjadMazini
--------------------------------

local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
local api_key = nil
local base_api = "https://maps.googleapis.com/maps/api"
--------------------------------
local function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
local function get_staticmap(area)
	local api        = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
--------------------------------
local function get_weather(location)
	print("Finding weather in ", location)
	local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
	local url = BASE_URL
	url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
	url = url..'&units=metric'
	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
	local weather = json:decode(b)
	local city = weather.name
	local country = weather.sys.country
	local temp = '`دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد`\n____________________'
	local conditions = '`شرایط فعلی آب و هوا `: '
	if weather.weather[1].main == 'Clear' then
		conditions = conditions .. 'آفتابی☀'
	elseif weather.weather[1].main == 'Clouds' then
		conditions = conditions .. 'ابری ☁☁'
	elseif weather.weather[1].main == 'Rain' then
		conditions = conditions .. 'بارانی ☔'
	elseif weather.weather[1].main == 'Thunderstorm' then
		conditions = conditions .. 'طوفانی ☔☔☔☔'
	elseif weather.weather[1].main == 'Mist' then
		conditions = conditions .. 'مه 💨'
	end
	return temp .. '\n' .. conditions
end
--------------------------------
local function calc(exp)
	url = 'http://api.mathjs.org/v1/'
	url = url..'?expr='..URL.escape(exp)
	b,c = http.request(url)
	text = nil
	if c == 200 then
    text = 'Result = '..b..'\n____________________'..msg_caption
	elseif c == 400 then
		text = b
	else
		text = 'Unexpected error\n'
		..'Is api.mathjs.org up?'
	end
	return text
end
--------------------------------
function exi_file(path, suffix)
    local files = {}
    local pth = tostring(path)
	local psv = tostring(suffix)
    for k, v in pairs(scandir(pth)) do
        if (v:match('.'..psv..'$')) then
            table.insert(files, v)
        end
    end
    return files
end
--------------------------------
function file_exi(name, path, suffix)
	local fname = tostring(name)
	local pth = tostring(path)
	local psv = tostring(suffix)
    for k,v in pairs(exi_file(pth, psv)) do
        if fname == v then
            return true
        end
    end
    return false
end
--------------------------------
function run(msg, matches) 
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
	if (matches[1]:lower() == 'calc' and not Clang) or (matches[1]:lower() == 'ماشین حساب' and Clang) and matches[2] then 
		if msg.to.type == "pv" then 
			return 
       end
		return calc(matches[2])
	end
--------------------------------
	if (matches[1]:lower() == 'ptime' and not Clang) or (matches[1]:lower() == 'زمان' and Clang) then
		if matches[2] then
			city = matches[2]
		elseif not matches[2] then
			city = 'Tehran'
		end
		local lat,lng,url	= get_staticmap(city)
		local dumptime = run_bash('date +%s')
		local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
		local jdat = json:decode(code)
		local data = jdat.data.timings
		local text = 'شهر : '..city
		text = text..'\n➰اذان صبح : '..data.Fajr
		text = text..'\n➰طلوع آفتاب : '..data.Sunrise
		text = text..'\n➰اذان ظهر : '..data.Dhuhr
		text = text..'\n➰غروب آفتاب : '..data.Sunset
		text = text..'\n➰اذان مغرب : '..data.Maghrib
		text = text..'\n➰عشاء : '..data.Isha
		text = text..msg_caption
		return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'html')
	end
--------------------------------
	if (matches[1]:lower() == 'tophoto' and not Clang) or (matches[1]:lower() == 'به عکس' and Clang) and msg.reply_id then
		function tophoto(arg, data)
			function tophoto_cb(arg,data)
				if data.content.sticker then
					local file = data.content.sticker.sticker.path
					local secp = tostring(tcpath)..'/data/stickers/'
					local ffile = string.gsub(file, '-', '')
					local fsecp = string.gsub(secp, '-', '')
					local name = string.gsub(ffile, fsecp, '')
					local sname = string.gsub(name, 'webp', 'jpg')
					local pfile = 'data/photos/'..sname
					local pasvand = 'webp'
					local apath = tostring(tcpath)..'/data/stickers'
					if file_exi(tostring(name), tostring(apath), '') then
						os.rename(file, pfile)
						        tdbot.sendPhoto(msg.to.id, msg.id, pfile, 0, {}, 0, 0, msg_caption, 0, 0, 1, nil, dl_cb, nil)
					else
						tdbot.sendMessage(msg.to.id, msg.id, 1, '`This sticker does not exist. Send sticker again.`'..msg_caption, 1, 'md')
					end
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`This is not a sticker.`', 1, 'md')
				end
			end
            tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, tophoto_cb, nil)
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_id }, tophoto, nil)
    end
--------------------------------
	if (matches[1]:lower() == 'tosticker' and not Clang) or (matches[1]:lower() == 'به استیکر' and Clang) and msg.reply_id then
		function tosticker(arg, data)
			function tosticker_cb(arg,data)
				if data.content._ == 'messagePhoto' then
					file = data.content.photo.id
					local pathf = tcpath..'/files/photos/'..file..'.jpg'
					if file_exi(file..'_(0).jpg', tcpath..'/files/photos', 'jpg') then
						pathf = tcpath..'/files/photos/'..file..'_(0).jpg'
					end
					local pfile = 'data/photos/'..file..'.webp'
					if file_exi(file..'.jpg', tcpath..'/files/photos', 'jpg') then
						os.rename(pathf, pfile)
						--tdbot.sendDocument(msg.to.id, pfile, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
						 tdbot.sendSticker(msg.to.id, msg.id, pfile, 512, 512, 1, nil, nil, dl_cb, nil)
					else
						tdbot.sendMessage(msg.to.id, msg.id, 1, '`This photo does not exist. Send photo again.`', 1, 'md')
					end
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`This is not a photo.`', 1, 'md')
				end
			end
			tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, tosticker_cb, nil)
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_id }, tosticker, nil)
    end
--------------------------------
	if (matches[1]:lower() == 'weather' and not Clang) or (matches[1]:lower() == 'دما' and Clang) then
		city = matches[2]
		local wtext = get_weather(city)
		if not wtext then
			wtext = '`مکان وارد شده صحیح نیست`'
		end
		return wtext
	end
--------------------------------
	if (matches[1]:lower() == 'time' and not Clang) or (matches[1]:lower() == 'ساعت' and Clang) then
		local url , res = http.request('http://api.beyond-dev.ir/time/')
		if res ~= 200 then
			return "No connection"
		end
		local colors = {'blue','green','yellow','magenta','Orange','DarkOrange','red'}
		local fonts = {'mathbf','mathit','mathfrak','mathrm'}
		local jdat = json:decode(url)
		local url = 'http://latex.codecogs.com/png.download?'..'\\dpi{600}%20\\huge%20\\'..fonts[math.random(#fonts)]..'{{\\color{'..colors[math.random(#colors)]..'}'..jdat.ENtime..'}}'
		local file = download_to_file(url,'time.webp')
		tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)

	end
--------------------------------
	if (matches[1]:lower() == 'tovoice' and not Clang) or (matches[1]:lower() == 'به صدا' and Clang) then
 local text = matches[2]
    textc = text:gsub(' ','.')
    
  if msg.to.type == 'pv' then 
      return nil
      else
  local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..textc
  local file = download_to_file(url,'AddminGuard.mp3')
 				tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
   end
end

 --------------------------------
	if (matches[1]:lower() == 'tr' and not Clang) or (matches[1]:lower() == 'ترجمه' and Clang) then 
		url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3]))
		data = json:decode(url)
		return 'زبان : '..data.lang..'\nترجمه : '..data.text[1]..'\n____________________'..msg_caption
	end
--------------------------------
if matches[1] == 'rank' or matches[1] == 'Rank' or matches[1] == 'مقام من' then
    if is_sudo(msg) then
    tdbot.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/sudo.webp', '', dl_cb, nil)
      return "*شما سودو هستید*"
    elseif is_admin(msg) then
    tdbot.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/admin.webp', '', dl_cb, nil)
      return "*شما ادمین هستید*"
    elseif is_owner(msg) then
    tdbot.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/owner.webp', '', dl_cb, nil)
      return "*شما مدیر گروه هستید*"
    elseif is_mod(msg) then
    tdbot.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/mod.webp', '', dl_cb, nil)
      return "*شما مالک گروه هستید*"
    else
    tdbot.sendDocument(msg.chat_id_, 0, 0, 1, nil, './Fun/member.webp', '', dl_cb, nil)
      return "*شما کاربر معمولی هستید*"
    end
  end
--------------------------------
	if (matches[1]:lower() == 'short' and not Clang) or (matches[1]:lower() == 'کوتاه' and Clang) then
		if matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = matches[2]
		elseif not matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = "https://"..matches[2]
		end
		local yon = http.request('http://api.yon.ir/?url='..URL.escape(shortlink))
		local jdat = json:decode(yon)
		local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(shortlink))
		local data = json:decode(bitly)
		local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(shortlink))
		local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(shortlink)..'&format=simple')
		local text = ' 🌐لینک اصلی :\n'..check_markdown(data.data.long_url)..'\n\nلینکهای کوتاه شده با 6 سایت کوتاه ساز لینک : \n》کوتاه شده با bitly :\n___________________________\n'..(check_markdown(data.data.url) or '---')..'\n___________________________\n》کوتاه شده با u2s :\n'..(check_markdown(u2s) or '---')..'\n___________________________\n》کوتاه شده با llink : \n'..(check_markdown(llink) or '---')..'\n___________________________\n》لینک کوتاه شده با yon : \nyon.ir/'..(check_markdown(jdat.output) or '---')..'\n____________________'..msg_caption
		return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'html')
	end
--------------------------------
if matches[1]:lower() == "sticker" or matches[1]:lower() == "استیکر" then
    local modes = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'}
    local text = URL.escape(matches[2])
    local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
    local title , res = http.request(url)
    local jdat = json:decode(title)
    local sticker = jdat.src
    local file = download_to_file(sticker,'sticker.webp')
     		tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
	end
--------------------------------
if matches[1]:lower() == "photo" or matches[1]:lower() == "عکس" then
    local modes = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'}
    local text = URL.escape(matches[2])
    local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
    local title , res = http.request(url)
    local jdat = json:decode(title)
    local sticker = jdat.src
    local file = download_to_file(sticker,'stiker.webp')
     		tdbot.sendPhoto(msg.to.id, msg.id, file, 0, {}, 0, 0, msg_caption, 0, 0, 1, nil, dl_cb, nil)
	end
--------------------------------
if matches[1]:lower() == 'love' or matches[1]:lower() == 'لاو' then
          local text1 = matches[2]
          local text2 = matches[3]
          local url = "http://www.iloveheartstudio.com/-/p.php?t=" .. text1 .. "%20%EE%BB%AE%20" .. text2 .. "&bc=FFFFFF&tc=000000&hc=ff0000&f=c&uc=true&ts=true&ff=PNG&w=500&ps=sq"
          local file = download_to_file(url, "love.webp")
          tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
        end
--------------------------------
 if matches[1] == "gif"or matches[1] =="گیف" and is_mod(msg) then 
    local modes = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'}
local text = URL.escape(matches[2]) 
  local url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=blue-fire&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141' 
  local title , res = http.request(url2) 
  local jdat = json:decode(title) 
  local gif = jdat.src 
  local file = download_to_file(gif,'t2g.gif') 
     tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
	end
--------------------------------
if matches[1] == "help" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpport_en = [[
*DelGuardTm Bot Help*

▎○help1
▎`Sudo Help`

▎●help2
▎`Lock Help`

▎○help3
▎`Mute Help`  

▎●help4
▎`Mod Help`

▎●help5
▎`Fun Help`

▎○help6
▎‌`Port Help` 

▎●help7
▎‌`AddGp Help` 

▎○help8
▎‌`More Help` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpport_en = [[
*راهنمای ربات ادمین گارد*

▎○help1
▎ `راهنما سودو`

▎●help2
▎ `راهنما قفلی`

▎○help3
▎ `راهنما ممنوعیتی`  

▎●help4
▎ `راهنما مدیریتی`

▎●help5
▎ `راهنما سرگرمی`

▎○help6
▎‌ `راهنما درگاه های پرداخت` 

▎●help7
▎‌ `راهنما اداجباری` 

▎○help8
▎‌ `راهنما سایرامکانات`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpport_en..msg_caption
end
if matches[1] == "راهنما" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpport_fa = [[
*DelGuardTm Bot Help*

▎ ○راهنما1
▎`Sudo Help`

▎ ●راهنما2
▎`Lock Help`

▎ ○راهنما3
▎`Mute Help`  

▎ ●راهنما4
▎`Mod Help`

▎ ●راهنما5
▎`Fun Help`

▎ ○راهنما6
▎‌`Port Help` 

▎ ●راهنما7
▎‌`AddGp Help` 

▎ ○راهنما8
▎‌`More Help`

﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpport_fa = [[
*راهنمای ربات ادمین گارد*

▎ ○راهنما1
▎ `راهنما سودو`

▎ ●راهنما2
▎ `راهنما قفلی`

▎ ○راهنما3
▎ `راهنما ممنوعیتی`  

▎ ●راهنما4
▎ `راهنما مدیریتی`

▎●راهنما5
▎ `راهنما سرگرمی`

▎ ○راهنما6
▎‌ `راهنما درگاه های پرداخت` 

▎ ●راهنما7
▎‌ `راهنما اداجباری` 

▎ ○راهنما8
▎‌ `راهنما سایرامکانات` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpport_fa..msg_caption
end

if matches[1] == "help1" and is_sudo(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpsudo_en = [[
*️DelGuardTm Sudo  Help*

▎ ○install
▎`Add the group to the robot management list`

▎ ○uninstall
▎`Delete the group from the robot management list`

▎○visudo `[id]`
▎`Add Sudo`

▎●desudo `[id]`
▎`Demote Sudo`

▎○sudolist
▎`Sudo(s) list`

▎●setadmin `[id]`
▎`Add admin for bot`

▎○remadmin `[id]`
▎`Demote bot admin`

▎●adminlist
▎`Admin(s) list`

▎○leave 
▎`Leave current group`

▎●autoleave `[+/-]`
▎`Automatically leaves group`

▎○creategroup `[text]`
▎`Create normal group`

▎●createsuper `[text]`
▎`Create supergroup`

▎○tosuper 
▎`Convert to supergroup`

▎●stats
▎`List of added groups`

▎○join `[id]`
▎`Adds you to the group`

▎●rem `[id]`
▎`Remove a group from Database`

▎○import `[link]`
▎`Bot joins via link`

▎●setbotname 
▎`Change bot's name`

▎○setusername 
▎`Change bot's username`

▎●remusername 
▎`Delete bot's username`

▎○markread `[+/-]`
▎`Second mark`

▎●sendall `[text]`
▎`Send message to all added groups`

▎○send `[text|Gpid]`
▎`Send message to a specific group`

▎●sendfile `[file]`
▎`Send file from folder`

▎○sendplug `[name]`
▎`Send plugin`

▎●save `[name]`
▎`Save plugin by reply`

▎○savefile `[name]`
▎`Save File by reply to specific folder`

▎●config
▎`Set Owner and Admin Group`

▎○clean cache
▎`Clear All Cache Of .telegram-cli/data`

▎●expire
▎`Stated Expiration Date`

▎○expire `[GroupID]`
▎`Stated Expiration Date Of Specific Group`

▎●expire `[Gid|dys]`
▎`Set Expire Time For Specific Group`

▎○expire `[days]`
▎`Set Expire Time For Group`

▎●jointo `[GroupID]`
▎`Invite You To Specific Group`

▎○leave `[GroupID]`
▎`Leave Bot From Specific Group`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpsudo_en = [[
*راهنمای سودو ادمین گارد*

▎ ○install
▎ `اضافه کردن گروه به لیست گروه مدیریتی ربات`

▎ ○uninstall
▎ `حذف کردن گروه از لیست گروه مدیریتی ربات`

▎○visudo `[id]`
▎ `اضافه کردن سودو`

▎●desudo `[id]`
▎ `حذف کردن سودو`

▎○sudolist
▎ `لیست سودو‌های ربات`

▎●setadmin `[id]`
▎ `اضافه کردن ادمین به ربات`

▎○remadmin `[id]`
▎ `حذف فرد از ادمینی ربات`

▎●adminlist
▎ `لیست ادمین ها`

▎○leave
▎ `خارج شدن ربات از گروه`

▎●autoleave `[+/-]`
▎ `خروج خودکار`

▎○creategroup `[text]`
▎ `ساخت گروه ریلم`

▎●createsuper `[text]`
▎ `ساخت سوپر گروه`

▎○tosuper
▎ `تبدیل به سوپر گروه`

▎●stats
▎ `لیست گروه های مدیریتی ربات`

▎○join `[ID]`
▎ `جوین شدن توسط ربات`

▎●rem `[GroupID]`
▎ `حذف گروه ازطریق پنل مدیریتی`

▎○import `[link]`
▎ `جوین شدن ربات توسط لینک`

▎●setbotname 
▎ `تغییر اسم ربات`

▎○setusername 
▎ `تغییر یوزرنیم ربات`

▎●remusername
▎ `پاک کردن یوزرنیم ربات`

▎○markread `[+/-]`
▎ `تیک دوم`

▎●sendall `[text]`
▎ `فرستادن پیام به تمام گروه های مدیریتی ربات`

▎○send `[text|Gpid]`
▎ `ارسال پیام مورد نظر به گروه خاص`

▎●sendfile `[file]`
▎ `ارسال فایل موردنظر از پوشه خاص`

▎○sendplug `[name]`
▎ `ارسال پلاگ مورد نظر`

▎●save `[name]`
▎ `ذخیره کردن پلاگین`

▎○savefile `[name]`
▎ `ذخیره کردن فایل در پوشه مورد نظر`

▎●config
▎ `اضافه کردن سازنده و مدیران گروه به مدیریت ربات`

▎○clean cache
▎ `پاک کردن کش`

▎●expire
▎ `اعلام تاریخ انقضای گروه`

▎○expire `[GroupID]`
▎ `اعلام تاریخ انقضای گروه مورد نظر`

▎●expire `[Gid|dys]`
▎ `تنظیم تاریخ انقضای گروه مورد نظر`

▎○expire `[days]`
▎ `تنظیم تاریخ انقضای گروه`

▎●jointo `[GroupID]`
▎ `دعوت شدن شما توسط ربات به گروه مورد نظر`

▎○leave `[GroupID]`
▎ `خارج شدن ربات از گروه مورد نظر`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpsudo_en..msg_caption
end

if matches[1] == "راهنما1" and is_sudo(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpsudo_fa = [[
*️DelGuardTm Sudo  Help*

▎ ○نصب
▎`Add the group to the robot management list`
▎ ○لغو نصب
▎`Delete the group from the robot management list`
▎ ○سودو `[id]`
▎ `Add Sudo`

▎ ●حذف سودو `[id]`
▎`Demote Sudo`

▎ ○لیست سودو
▎`Sudo(s) list`

▎ ●تنظیم ادمین `[id]`
▎`Add admin for bot`

▎ ○حذف ادمین `[id]`
▎`Demote bot admin`

▎ ●لیست ادمین
▎`Admin(s) list`

▎ ○خروج از گروه 
▎`Leave current group`

▎ ●خروج خودکار `[+/-]`
▎`Automatically leaves group`

▎ ○ساخت گروه 
▎`Create normal group`

▎ ●ساخت سوپرگروه 
▎`Create supergroup`

▎ ○تبدیل به سوپرگروه 
▎`Convert to supergroup`

▎ ●امار
▎`List of added groups`

▎ ○افزودن `[id]`
▎`Adds you to the group`

▎ ●حذف `[id]`
▎`Remove a group from Database`

▎ ○ورود لینک `[link]`
▎`Bot joins via link`

▎ ●تغییر نام 
▎`Change bot's name`

▎ ●حذف یوزرنیم 
▎`Change bot's username`

▎ ●حذف یوزرنیم 
▎`Delete bot's username`

▎ ○تیک دوم `[+/-]`
▎`Second mark`

▎ ●ارسال به همه `[text]`
▎`Send message to all added groups`

▎ ○ارسال `[text] [Ggid]`
▎`Send message to a specific group`

▎ ●ارسال فایل `[file]`
▎`Send file from folder`

▎ ○ارسال پلاگین `[name]`
▎`Send plugin`

▎ ●ذخیره پلاگین `[name]`
▎`Save plugin by reply`

▎ ○ذخیره فایل `[name]`
▎`Save File by reply to specific folder`

▎ ●ارتقا گروه
▎`Set Owner and Admin Group`

▎ ○پاکسازی حافظه
▎`Clear All Cache Of .telegram-cli/data`

▎ ●انقضا
▎`Stated Expiration Date`

▎ ○انقضا `[GroupID]`
▎`Stated Expiration Date Of Specific Group`

▎ ●انقضا `[ Gpid/days ]`
▎`Set Expire Time For Specific Group`

▎ ○انقضا `[ days ]`
▎`Set Expire Time For Group`

▎ ●ورود به `[GroupID]`
▎`Invite You To Specific Group`

▎ ○خروج از گروه `[Gpid]`
▎`Leave Bot From Specific Group`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpsudo_fa = [[
*راهنمای سودو ادمین گارد*

▎ ○نصب
▎ `اضافه کردن گروه به لیست گروه مدیریتی ربات`

▎ ○لغو نصب
▎ `حذف کردن گروه از لیست گروه مدیریتی ربات`

▎ ○سودو `[id]`
▎ `اضافه کردن سودو`

▎ ●حذف سودو `[id]`
▎ `حذف کردن سودو`

▎ ○لیست سودو
▎ `لیست سودو‌های ربات`

▎ ●تنظیم ادمین `[id]`
▎ `اضافه کردن ادمین به ربات`

▎ ○حذف ادمین `[id]`
▎ `حذف فرد از ادمینی ربات`

▎ ●لیست ادمین
▎ `لیست ادمین ها`

▎ ○خروج از گروه
▎ `خارج شدن ربات از گروه`

▎ ●خروج خودکار `[+/-]`
▎ `خروج خودکار`

▎ ○ساخت گروه 
▎ `ساخت گروه ریلم`

▎ ●ساخت سوپرگروه 
▎ `ساخت سوپر گروه`

▎ ○تبدیل به سوپرگروه
▎ `تبدیل به سوپر گروه`

▎ ●امار
▎ `لیست گروه های مدیریتی ربات`

▎ ○افزودن `[ID]`
▎ `جوین شدن توسط ربات`

▎ ●حذف `[GroupID]`
▎ `حذف گروه ازطریق پنل مدیریتی`

▎ ○ورود لینک `[link]`
▎ `جوین شدن ربات توسط لینک`

▎ ●تغییر نام 
▎ `تغییر اسم ربات`

▎ ○تنظیم یوزرنیم 
▎ `تغییر یوزرنیم ربات`

▎ ●حذف یوزرنیم
▎ `پاک کردن یوزرنیم ربات`

▎ ○تیک دوم `[+/-]`
▎ `تیک دوم`

▎ ●ارسال به همه `[text]`
▎ `فرستادن پیام به تمام گروه های مدیریتی ربات`

▎ ○ارسال `[text|Gpid]`
▎ `ارسال پیام مورد نظر به گروه خاص`

▎ ●ارسال فایل `[file]`
▎ `ارسال فایل موردنظر از پوشه خاص`

▎ ○ارسال پلاگین `[name]`
▎ `ارسال پلاگ مورد نظر`

▎ ●ذخیره پلاگین `[name]`
▎ `ذخیره کردن پلاگین`

▎ ○ذخیره فایل `[name]`
▎ `ذخیره کردن فایل در پوشه مورد نظر`

▎ ●ارتقا گروه
▎ `اضافه کردن سازنده و مدیران گروه به مدیریت ربات`

▎ ○پاکسازی حافظه
▎ `پاک کردن کش`

▎ ●انقضا
▎ `اعلام تاریخ انقضای گروه`

▎ ○انقضا `[GroupID]`
▎ `اعلام تاریخ انقضای گروه مورد نظر`

▎ ●انقضا `[Gid|dys]`
▎ `تنظیم تاریخ انقضای گروه مورد نظر`

▎ ○انقضا `[days]`
▎ `تنظیم تاریخ انقضای گروه`

▎ ●ورود به `[GroupID]`
▎ `دعوت شدن شما توسط ربات به گروه مورد نظر`

▎ ○خروج از گروه `[Gpid]`
▎ `خارج شدن ربات از گروه مورد نظر`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpsudo_fa..msg_caption
end

if matches[1] == "help2" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helplock_en = [[
*DelGuardTm Lock Help*

*enabled Locked🔐*

▎○lock [`link` | `tag` | `edit` | `arabic` | `webpage` | `bots` | `spam` | `flood` | `markdown` | `mention` | `pin` | `join`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*Disable Locked🔓*

▎●unlock [`link` | `tag` | `edit` | `arabic` | `webpage` | `bots` | `spam` | `flood` | `markdown` | `mention` | `pin` | `join`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helplock_en = [[
*راهنمای قفلی ادمین گارد*

*فعال سازی قفل ها🔐*

▎○lock [`link` | `tag` | `edit` | `arabic` | `webpage` | `bots` | `spam` | `flood` | `markdown` | `mention` | `pin`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*غیرفعال سازی قفل ها🔓*

▎●unlock [`link` | `tag` | `edit` | `arabic` | `webpage` | `bots` | `spam` | `flood` | `markdown` | `mention` | `pin`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helplock_en..msg_caption
end

if matches[1] == "راهنما2" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helplock_fa = [[
*DelGuardTm Lock Help*

*enabled Locked🔐*

▎ ●قفل [`لینک` | `تگ` | `ویرایش` | `عربی` | `وب` | `ربات` | `اسپم` | `فلود` | `فونت` | `فراخوانی` | `سنجاق` | `جوین`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*Disable Locked🔓*

▎ ●بازکردن [`لینک` | `تگ` | `ویرایش` | `عربی` | `وب` | `ربات` | `اسپم` | `فلود` | `فونت` | `فراخوانی` | `سنجاق` | `جوین`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helplock_fa = [[
*راهنمای قفلی ادمین گارد*

*فعال سازی قفل ها🔐*

▎ ●قفل [`لینک` | `تگ` | `ویرایش` | `عربی` | `وب` | `ربات` | `اسپم` | `فلود` | `فونت` | `فراخوانی` | `سنجاق` | `جوین`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*غیرفعال سازی قفل ها🔓*

▎ ●بازکردن [`لینک` | `تگ` | `ویرایش` | `عربی` | `وب` | `ربات` | `اسپم` | `فلود` | `فونت` | `فراخوانی` | `سنجاق` | `جوین`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helplock_fa..msg_caption
end

if matches[1] == "help3" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helplock_en = [[
*DelGuardTm LockMedia Help*

*enabled Muted🔇*

▎○mute [`gif` | `photo` | `document` | `sticker` | `keyboard` | `video` | `video_note` | `text` | `forward` | `location` | `audio` | `voice` | `contact` | `group`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*Disable Muted🔈*

▎●unmute [`gif` | `photo` | `document` | `sticker` | `keyboard` | `video` | `video_note` | `text` | `forward` | `location` | `audio` | `voice` | `contact` | `group`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helplock_en = [[
*راهنمای قفل رسانه ادمین گارد*

*فعال سازی ممنوعیت ها🔇*

▎○mute [`gif` | `photo` | `document` | `sticker` | `keyboard` | `video` | `video_note` | `text` | `forward` | `location` | `audio` | `voice` | `contact` | `group`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*غیرفعال سازی ممنوعیت ها🔈*

▎●unmute [`gif` | `photo` | `document` | `sticker` | `keyboard` | `video` | `video_note` | `text` | `forward` | `location` | `audio` | `voice` | `contact` | `group`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helplock_en..msg_caption
end

if matches[1] == "راهنما3" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helplock_fa = [[
*DelGuardTm LockMedia Help*

*enabled Muted🔇*

▎ ●بیصدا [`گروه` | `گیف` | `عکس` | `فایل` | `استیکر` | کیبورد | `فیلم` | `فیلم سلفی` | `متن` | `فوروارد` | `موقعیت` | اهنگ | `ویس` | `مخاطب` | `شیشه ای` | `بازی` | `سرویس`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*Disable Muted🔈*

▎ ●باصدا [`گروه` | `گیف` | `عکس` | `فایل` | `استیکر` | کیبورد | `ویدیو` | `فیلم سلفی` | `متن` | `فوروارد` | `موقعیت` | اهنگ | `ویس` | `مخاطب` | `اینلاین` | `بازی` | `سرویس`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helplock_fa = [[
*راهنمای قفل رسانه ادمین گارد*

*فعال سازی ممنوعیت ها🔇*

▎ ●بیصدا [`گروه` | `گیف` | `عکس` | `فایل` | `استیکر` | کیبورد | `ویدیو` | `فیلم سلفی` | `متن` | `فوروارد` | `موقعیت` | اهنگ | `ویس` | `مخاطب` | `اینلاین` | `بازی` | `سرویس`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏

*غیرفعال سازی ممنوعیت ها🔇*

▎ ●باصدا [`گروه` | `گیف` | `عکس` | `فایل` | `استیکر` | کیبورد | `فیلم` | `فیلم سلفی` | `متن` | `فوروارد` | `موقعیت` | اهنگ | `ویس` | `مخاطب` | `شیشه ای` | `بازی` | `سرویس`]
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helplock_fa..msg_caption
end

if matches[1] == "help4" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helplock_en = [[
*DelGuardTm Mod Help*

▎ ○setowner `[id]` 
▎`Set Group Owner(Multi Owner)`

▎ ●remowner` [id] `
▎` Remove User From Owner List`

▎ ○promote` [id] `
▎`Promote User To Group Admin`

▎ ●demote `[id] `
▎`Demote User From Group Admins List`

▎ ○setflood` [1-50]`
▎`Set Flooding Number`

▎ ●setchar `[1-100]`
▎`Set Flooding Characters`

▎ ○setfloodtime` [1-10]`
▎`Set Flooding Time`

▎ ●silent` [reply] `
▎`Silent User From Group`

▎ ○unsilent` [reply] `
▎`Unsilent User From Group`

▎ ●kick` [id] `
▎`Kick User From Group`

▎ ○ban` [id] `
▎`Ban User From Group`

▎ ●unban `[id] `
▎`UnBan User From Group`

▎ ○vip` [+-] [relpy] `
▎`Add Or Remove User From White List`

▎ ●res` [username]`
▎`Show User ID`

▎ ○id` [reply]`
▎`Show User ID`

▎ ●whois` [id]`
▎`Show User's Username And Name`

▎ ○filter` [word]`
▎`Word filter`

▎ ●unfilter` [word]`
▎`Word unfilter`

▎ ○pin `[reply]`
▎`Pin Your Message`

▎ ●unpin 
▎`Unpin Pinned Message`

▎ ○welcome +/-
▎`Enable Or Disable Group Welcome`

▎ ●settings1
▎`Show Group Settings`

▎ ○settings2
▎`Show Mutes List`

▎ ●silentlist
▎`Show Silented Users List`

▎ ○filterlist
▎`Show Filtered Words List`

▎ ●banlist
▎`Show Banned Users List`

▎ ○ownerlist
▎`Show Group Owners List `

▎ ●modlist 
▎`Show Group Moderators List`

▎ ○viplist
▎`Show Group White List Users`

▎ ●rules
▎`Show Group Rules`

▎ ○about
▎`Show Group Description`

▎ ●id
▎`Show Your And Chat ID`

▎ ○gpid 
▎`Show Group Information`

▎ ●newlink
▎`Create A New Link`

▎ ○setlink
▎`Set A New Link`

▎ ●link
▎`Show Group Link`

▎ ○linkpv
▎`Send Group Link In Your Private` Message

▎ ●setwelcome 
▎`set Welcome Message`

▎ ○setlang` [fa | en]`
▎`Set Persian/English Language`

▎ ●setcmd` [fa | en]`
▎`Set CMD Persian/English Language`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm
]]
else

helplock_en = [[
*️راهنما مدیریتی  ادمین گارد*

▎○setowner `[id]` 
▎ `تنظیم مالک برای گروه`

▎●remowner` [id] `
▎ `حذف مالک گروه`

▎○promote` [id] `
▎ `تنظیم ادمین گروه`

▎●demote `[id] `
▎ `حذف ادمین گروه`

▎○setflood` [1-50]`
▎ `تنظیم فلود`

▎●setchar `[1-100]`
▎ `تنظیم حروف مجاز`

▎○setfloodtime` [1-10]`
▎ `تنظیم زمان برسی`

▎●silent` [reply] `
▎ `سکوت کردن کاربر`

▎○unsilent` [reply] `
▎ `حذف کردن کاربر از سکوت`

▎●kick` [id] `
▎ `اخراج کاربر`

▎○ban` [id] `
▎ `مسدود کاربر`

▎●unban `[id] `
▎ `حذف کردن کاربر از مسدود`

▎○vip` [+-] [relpy] `
▎ `ویژه کردن کاربر`

▎●res` [username]`
▎ `دریافت شناسه`

▎○id` [reply]`
▎ `دریافت شناسه`

▎●whois` [id]`
▎ `دریافت شناسه و یوزرنیم`

▎○filter` [word]`
▎ `فیلتر کردن کلمه`

▎●unfilter` [word]`
▎ `حذف کردن  از لیستر فیلتر`

▎○pin `[reply]`
▎ `سنجاق کردن پیام`

▎●unpin 
▎ `حذف کردن سنجاق`

▎○welcome +/-
▎ `خاموش | روشن کردن خوش آمدگویی`

▎●settings1
▎ `تنظیمات قفلی`

▎○settings2
▎ `تنظیمات رسانه`

▎●silentlist
▎ `لیست کاربران محروم از چت `

▎○filterlist
▎ `لیست کلمات غیرمجاز`

▎●banlist 
▎ `لیست مسدود ها`

▎○ownerlist 
▎ `لیست مالکان`

▎●modlist 
▎ `لیست مدیران`

▎○viplist
▎ `لیست کاربران ویژه`

▎●rules
▎ `قوانین گروه`

▎○about
▎ `نمایش درباره گروه`

▎●id
▎ `نمایش شناسه شما و گروه`

▎○gpid 
▎ `اطلاعات گروه`

▎●newlink
▎ `ساخت لینک جدید`

▎○setlink
▎ `تنظیم لینک گروه`

▎●link
▎ `نمایش لینک گروه`

▎○linkpv
▎ `ارسال لینک به پیوی شما`

▎●setwelcome 
▎ `تنظیم خوش آمدگویی`

▎○setlang` [fa | en]`
▎ `تنظیم  زبان فارسی | انگلیسی`

▎●setcmd` [fa | en]`
▎ `تتظیم دستورات فارسی | انگلیسی`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helplock_en..msg_caption
end

if matches[1] == "راهنما4" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helplock_fa = [[
*DelGuardTm Mod Help*

▎ ○صاحب `[id]` 
▎`Set Group Owner(Multi Owner)`

▎ ●حذف صاحب` [id] `
▎` Remove User From Owner List`

▎ ○ترفیع` [id] `
▎`Promote User To Group Admin`

▎ ●تنزل `[id] `
▎`Demote User From Group Admins List`

▎ ○تنظیم پیام مکرر` [1-50]`
▎`Set Flooding Number`

▎ ●حداکثر حروف مجاز `[1-100]`
▎`Set Flooding Characters`

▎ ○تنظیم زمان بررسی` [1-10]`
▎`Set Flooding Time`

▎ ●سکوت` [reply] `
▎`Silent User From Group`

▎ ○حذف سکوت` [reply] `
▎`Unsilent User From Group`

▎ ●اخراج` [id] `
▎`Kick User From Group`

▎ ○مسدود` [id] `
▎`Ban User From Group`

▎ ●حذف مسدود `[id] `
▎`UnBan User From Group`

▎ ○ویژه` [+-] [relpy] `
▎`Add Or Remove User From White List`

▎ ●کاربری` [username]`
▎`Show User ID`

▎ ○ایدی` [reply]`
▎`Show User ID`

▎ ●شناسه` [id]`
▎`Show User's Username And Name`

▎ ○فیلتر` [word]`
▎`Word filter`

▎ ●حذف فیلتر` [word]`
▎`Word unfilter`

▎ ○سنجاق `[reply]`
▎`Pin Your Message`

▎ ●حذف سنجاق 
▎`Unpin Pinned Message`

▎ ○خوشامد +/-
▎`Enable Or Disable Group Welcome`

▎ ●تنظیمات1
▎`Show Group Settings`

▎ ○تنظیمات2
▎`Show Mutes List`

▎ ●لیست سکوت
▎`Show Silented Users List`

▎ ○لیست فیلتر
▎`Show Filtered Words List`

▎ ●لیست مسدود
▎`Show Banned Users List`

▎ ○لیست صاحب
▎`Show Group Owners List `

▎ ●لیست مدیران 
▎`Show Group Moderators List`

▎ ○لیست ویژه
▎`Show Group White List Users`

▎ ●قوانین
▎`Show Group Rules`

▎ ○درباره
▎`Show Group Description`

▎ ●ایدی
▎`Show Your And Chat ID`

▎ ○اطلاعات 
▎`Show Group Information`

▎ ●لینک جدید
▎`Create A New Link`

▎ ○تنظیم لینک
▎`Set A New Link`

▎ ●لینک
▎`Show Group Link`

▎ ○لینک پیوی
▎`Send Group Link In Your Private` Message

▎ ●تنظیم خوشامد 
▎`set Welcome Message`

▎ ○زبان` [فارسی | انگلیسی]`
▎`Set Persian/English Language`

▎ ●دستورات` [فارسی | انگلیسی]`
▎`Set CMD Persian/English Language`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helplock_fa = [[
*️راهنما مدیریتی  ادمین گارد*

▎ ○صاحب `[id]` 
▎ `تنظیم مالک برای گروه`

▎ ●حذف صاحب` [id] `
▎ `حذف مالک گروه`

▎ ○ترفیع` [id] `
▎ `تنظیم ادمین گروه`

▎ ●تنزل `[id] `
▎ `حذف ادمین گروه`

▎ ○تنظیم پیام مکرر` [1-50]`
▎ `تنظیم فلود`

▎ ●حداکثر حروف مجاز `[1-100]`
▎ `تنظیم حروف مجاز`

▎ ○تنظیم زمان بررسی` [1-10]`
▎ `تنظیم زمان برسی`

▎ ●سکوت` [reply] `
▎ `سکوت کردن کاربر`

▎ ○حذف سکوت` [reply] `
▎ `حذف کردن کاربر از سکوت`

▎ ●اخراج` [id] `
▎ `اخراج کاربر`

▎ ○مسدود` [id] `
▎ `مسدود کاربر`

▎ ●حذف مسدود `[id] `
▎ `حذف کردن کاربر از مسدود`

▎ ○ویژه` [+-] [relpy] `
▎ `ویژه کردن کاربر`

▎ ●کاربری` [username]`
▎ `دریافت شناسه`

▎ ○ایدی` [reply]`
▎ `دریافت شناسه`

▎ ●شناسه` [id]`
▎ `دریافت شناسه و یوزرنیم`

▎ ○فیلتر` [word]`
▎ `فیلتر کردن کلمه`

▎ ●حذف فیلتر` [word]`
▎ `حذف کردن  از لیستر فیلتر`

▎ ○سنجاق `[reply]`
▎ `سنجاق کردن پیام`

▎ ●حذف سنجاق 
▎ `حذف کردن سنجاق`

▎ ○خوشامد +/-
▎ `خاموش | روشن کردن خوش آمدگویی`

▎ ●تنظیمات1
▎ `تنظیمات قفلی`

▎ ○تنظیمات2
▎ `تنظیمات رسانه`

▎ ●لیست سکوت
▎ `لیست کاربران محروم از چت `

▎ ○لیست فیلتر
▎ `لیست کلمات غیرمجاز`

▎ ●لیست مسدود 
▎ `لیست مسدود ها`

▎ ○لیست صاحب 
▎ `لیست مالکان`

▎ ●لیست مدیران 
▎ `لیست مدیران`

▎ ○لیست ویژه
▎ `لیست کاربران ویژه`

▎ ●قوانین
▎ `قوانین گروه`

▎ ○درباره
▎ `نمایش درباره گروه`

▎ ●ایدی
▎ `نمایش شناسه شما و گروه`

▎ ○اطلاعات 
▎ `اطلاعات گروه`

▎ ●لینک جدید
▎ `ساخت لینک جدید`

▎ ○تنظیم لینک
▎ `تنظیم لینک گروه`

▎ ●لینک
▎ `نمایش لینک گروه`

▎ ○لینک پیوی
▎ `ارسال لینک به پیوی شما`

▎ ●تنظیم خوشامد 
▎ `تنظیم خوش آمدگویی`

▎ ○زبان` [فارسی | انگلیسی]`
▎ `تنظیم  زبان فارسی | انگلیسی`

▎ ●دستورات` [فارسی | انگلیسی]`
▎ `تتظیم دستورات فارسی | انگلیسی`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helplock_fa..msg_caption
end

if matches[1] == "help5" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpfun_en = [[
*DelGuardTm Fun Help*

▎○time
▎`Get time in a sticker`

▎●short `[link]`
▎`Make short url`

▎○tovoice `[text]`
▎`Convert text to voice`

▎●tr `[lang]`
▎`Translates FA to EN`

▎○sticker `[word]`
▎`Convert text to sticker`

▎●photo `[word]`
▎`Convert text to photo`

▎○calc 
▎Calculator

▎●ptime `[city]`
▎`Get Patent (Pray Time)`

▎○tosticker `[reply]`
▎`Convert photo to sticker`

▎●tophoto `[reply]`
▎`Convert text to photo`

▎○weather `[city]`
▎`Get weather`

▎●aparat `[text]`
▎`Sarch to aparat`

▎○online 
▎`Bot online`

▎●love `[word]`
▎`Convert text to Love`

▎○gif `[word]`
▎`Convert text to gif`

▎●font `[word]`
▎`Convert text to 100 font`

▎○joke 
▎`Send Joke`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpfun_en = [[
*️راهنما سرگرمی  ادمین گارد*

▎○time
▎ `دریافت ساعت به صورت استیکر`

▎●short `[link]`
▎ `کوتاه کننده لینک`

▎○tovoice `[text]`
▎ `تبدیل متن به صدا`

▎●tr `[lang] [word]`
▎ `ترجمه متن فارسی به انگلیسی `

▎○sticker `[word]`
▎ `تبدیل متن به استیکر`

▎●photo `[word]`
▎ `تبدیل متن به عکس`

▎○calc `[number]`
▎ `ماشین حساب`

▎●ptime `[city]`
▎ `اعلام ساعات شرعی`

▎○tosticker `[reply]`
▎ `تبدیل عکس به استیکر`

▎●tophoto `[reply]`
▎ `تبدیل استیکر‌به عکس`

▎○weather `[city]`
▎ `دریافت اب وهوا`

▎●aparat `[text]`
▎ `سرچ در اپارت`

▎○online 
▎ `اطلاع از انلاینی ربات`

▎●love `[‌word]`
▎ `تبدیل متن به استیکر عاشقانه`

▎○gif `[‌word]`
▎ `تبدیل متن به گیف`

▎●font `[‌text]`
▎ `زیبا سازی متن با 100 فونت`

▎○joke 
▎ `ارسال جوک `
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpfun_en..msg_caption
end

if matches[1] == "راهنما5" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpfun_fa = [[
*DelGuardTm Fun Help)*

▎ ○ساعت
▎`Get time in a sticker`

▎ ●کوتاه `[link]`
▎`Make short url`

▎ ○به صدا `[text]`
▎`Convert text to voice`

▎ ●ترجمه `[lang]`
▎`Translates FA to EN`

▎ ○استیکر `[word]`
▎`Convert text to sticker`

▎ ●عکس `[word]`
▎`Convert text to photo`

▎ ○ماشین حساب 
▎`Calculator`

▎ ●زمان `[city]`
▎`Get Patent (Pray Time)`

▎ ○به استیکر `[reply]`
▎`Convert photo to sticker`

▎ ●به عکس `[reply]`
▎`Convert text to photo`

▎ ○دما `[city]`
▎`Get weather`

▎ ●اپارات `[text]`
▎`Sarch to aparat`

▎ ○انلاینی 
▎`Bot online`

▎ ●لاو `[word]`
▎`Convert text to Love`

▎ ○گیف `[word]`
▎`Convert text to gif`

▎ ●فونت `[word]`
▎`Convert text to 100 font`

▎ ●جوک 
▎`Send Joke`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpfun_fa = [[
*️راهنما سرگرمی  ادمین گارد*

▎ ○ساعت
▎ `دریافت ساعت به صورت استیکر`

▎ ●کوتاه `[link]`
▎ `کوتاه کننده لینک`

▎ ○به صدا `[text]`
▎ `تبدیل متن به صدا`

▎ ●ترجمه `[lang]`
▎ `ترجمه متن فارسی به انگلیسی `

▎ ○استیکر `[word]`
▎ `تبدیل متن به استیکر`

▎ ●عکس `[word]`
▎ `تبدیل متن به عکس`

▎ ○ماشین حساب 
▎ `ماشین حساب`

▎ ●زمان `[city]`
▎ `اعلام ساعات شرعی`

▎ ○به استیکر `[reply]`
▎ `تبدیل عکس به استیکر`

▎ ●به عکس `[reply]`
▎ `تبدیل استیکر‌به عکس`

▎ ○دما `[city]`
▎ `دریافت اب وهوا`

▎ ‌●اپارات `[text]`
▎ `سرچ در اپارت`

▎ ○انلاینی 
▎ `اطلاع از انلاینی ربات`

▎ ●لاو `[‌word]`
▎ `تبدیل متن به استیکر عاشقانه`

▎ ○گیف `[‌word]`
▎ `تبدیل متن به گیف`

▎ ●فونت `[‌text]`
▎ `زیبا سازی متن با 100 فونت`

▎ ●جوک
▎ `ارسال جوک`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpfun_fa..msg_caption
end

if matches[1] == "help6" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpport_en = [[
*DelGuardTm Payment gateway Help*

▎○port1
▎`One-month payment`

▎●prot2 
▎`2-month payment`

▎○port3
▎`3-month payment  `

▎●port4
▎`4-month payment`

▎○portlist
▎`List of paid ports` 

▎○card number
▎`Get a card number` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpport_en = [[
*️راهنما درگاه های پرداختی  ادمین گارد*

▎○port1
▎ `دریافت درگاه 1ماهه`

▎●prot2 
▎ `دریافت درگاه 2ماهه`

▎○port3
▎ `دریافت درگاه 3ماهه`  

▎●port4
▎ `دریافت درگاه 4ماهه`

▎○portlist
▎ `دریافت لیست درگاه ها` 
▎○card number
▎ `دریافت شماره کارت` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpport_en..msg_caption
end
if matches[1] == "راهنما6" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpport_fa = [[
*DelGuardTm Payment gateway Help*

▎ ○درگاه1
▎`One-month payment`

▎ ●درگاه2 
▎`2-month payment`

▎ ○درگاه3
▎`3-month payment  `

▎ ●درگاه4
▎`4-month payment`

▎ ○لیست درگاه
▎`List of paid ports `
▎ ○شماره کارت
▎`Get a card number `

﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpport_fa = [[
*️راهنما درگاه های پرداختی  ادمین گارد*

▎ ○درگاه1
▎  `دریافت درگاه 1ماهه`

▎ ●درگاه2 
▎  `دریافت درگاه 2ماهه`

▎ ○درگاه3
▎  `دریافت درگاه 3ماهه`  

▎ ●درگاه4
▎  `دریافت درگاه 4ماهه`

▎ ○لیست درگاه
▎‌  `دریافت لیست درگاه ها` 

▎ ○شماره کارت
▎‌  `دریافت شماره کارت` 
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpport_fa..msg_caption
end

if matches[1] == "help7" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpaddgp_en = [[
*DelGuardTm GpAddUser  Help*

▎○lock add
▎`Locking add user`

▎●unlock add 
▎`Unlocking add user`

▎○setadd `[1-10]`
▎`Set Add Mandatory User`

▎●getadd
▎`Checked Numbers`

▎○addpm {on-off}
▎`Turned off the forced force`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpaddgp_en = [[
*️راهنما ادداجباری گروه  ادمین گارد*

▎○lock add
▎ `روشن کردن ادد اجباری`

▎●unlock add 
▎ `خاموش کردن ادد اجباری`

▎○setadd `[1-10]`
▎ `تنظیم تعداد ادد اجباری`

▎●getadd
▎ `چک تنظیم شده تعداد`

▎○addpm {on-off}
▎ `خاموش روشن کردن پیام ادد`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpaddgp_en..msg_caption
end

if matches[1] == "راهنما7" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpaddgp_fa = [[
*DelGuardTm GpAddUser  Help*

▎ ○قفل اداجباری
▎`Locking add user`

▎ ●بازکردن اداجباری 
▎`Unlocking add user`

▎ ○تنظیم اداجباری `[10-1]`
▎`Set Add Mandatory User`

▎ ●تعداد اجباری
▎`Checked Numbers`

▎ ○پیام اداجباری {فعال-غیرفعال}
▎`Turned off the forced force`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpaddgp_fa = [[
*️راهنما ادداجباری گروه  ادمین گارد*

▎ ○قفل اداجباری
▎  `روشن کردن ادد اجباری`

▎ ●بازکردن اداجباری
▎ `خاموش کردن ادد اجباری`

▎  ○تنظیم اداجباری `[10-1]`
▎  `تنظیم تعداد ادد اجباری`

▎ ●تعداد اداجباری
▎  `چک کردن تعداد تنظیم شده `

▎ ○پیام اداجباری {فعال-غیرفعال}
▎  `خاموش روشن کردن پیام ادد`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpaddgp_fa..msg_caption
end

if matches[1] == "help8" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpport_en = [[
*DelGuardTm ‌More Help*

▎○warn
▎`Warn Is Mamber`

▎●unwarn
▎`UnWarn Is Mamber`

▎○warnlist
▎`List Warn`

▎●banlist
▎`Ban List`

▎○mutelist
▎`Mute List`

▎●ownerlist
▎`Owner List`

▎○modliat
▎`Mod List`

▎●adminlist
▎`Admin List`

▎○delall `[reply]`
▎`Del Chat Is Mamber`

▎●set [`rules` | `warn` | `owner` | `admin` | `name` | `link` | `about` | `welcome`]
▎`Bot Set Them`  

▎○clean [`bans` | `msgs` | `warn` | `owners` | `mods` | `bots` | `rules` | `about` | `silent` | `filter` | `welcome`]  
▎`Bot Clean Them`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpport_en = [[
*️راهنما سایرامکانات  ادمین گارد*

▎○warn
▎ `اخطار دادن به کاربر`

▎●unwarn
▎ `حذف اخطار کاربر`

▎○warnlist
▎ `لیست کاربران اخطار`

▎●banlist
▎ `لیست کاربران مسدود`

▎○mutelist
▎ `لیست کاربران سکوت`

▎●ownerlist
▎ `لیست صاحبان`

▎○modliat
▎ `لیست مدیران`

▎●adminlist
▎ `لیست ادمین ها`

▎○delall `[reply]`
▎ `حذف پیام های کاربر`

▎●set [`rules` | `warn` | `owner` | `admin` | `name` | `link` | `about` | `welcome`]
▎ `لیست دستورات تنظیمی`  

▎○clean [`bans` | `msgs` | `warn` | `owners` | `mods` | `bots` | `rules` | `about` | `silent` | `filter` | `welcome`]   
▎ `لیست پاکسازی ها`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpport_en..msg_caption
end
if matches[1] == "راهنما8" and is_mod(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpport_fa = [[
*DelGuardTm More Help*

▎ ○اخطار
▎`Warn Is Mamber`

▎‌ ●حدف اخطار
▎`UnWarn Is Mamber`

▎ ○لیست اخطار
▎`List Warn`

▎ ●لیست مسدود
▎`Ban List`

▎ ○لیست سکوت
▎`Mute List`

▎ ●لیست صاحب
▎`Owner List`

▎ ○لیست مدیران
▎`Mod List`

▎ ●لیست ادمین
▎`Admin List`

▎ ○حذف همه `[reply]`
▎`Del Chat Is Mamber`

▎ ●تنظیم [`قوانین` | `اخطار` | `ادمین` | `نام` | `لینک` | `درباره` | `خوشامد`]
▎`Bot Set Them`  

▎‌ ○پاکسازی [`مسدود` | `پیام ها` | `اخطار` | `صاحب` | `مدیران` | `ربات` | `قوانین` | `درباره` | `سکوت` | `فیلتر` | `خوشامد`]   
▎`Bot Clean Them`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅By: @GirlSudo
🏅Channel:
@DelGuardTm]]
else

helpport_fa = [[
*️راهنما سایرامکانات  ادمین گارد*

▎ ○اخطار
▎ `اخطار دادن به کاربر`

▎ ●حذف اخطار
▎ `حذف اخطار کاربر`

▎ ○لیست اخطار
▎ `لیست کاربران اخطار`

▎ ●لیست مسدود
▎ `لیست کاربران مسدود`

▎ ○لیست سکوت
▎ `لیست کاربران سکوت`

▎ ●لیست صاحب
▎ `لیست صاحبان`

▎ ○لیست مدیران
▎ `لیست مدیران`

▎ ●لیست ادمین
▎ `لیست ادمین ها`

▎ ○حذف همه `[reply]`
▎ `حذف پیام های کاربر`

▎ ●تنظیم [`قوانین` | `اخطار`  | `ادمین` | `نام` | `لینک` | `درباره` | `خوشامد`]
▎ `لیست دستورات تنظیمی`  

▎‌ ○پاکسازی [`مسدود` | `پیام ها` | `اخطار` | `صاحب` | `مدیران` | `ربات` | `قوانین` | `درباره` | `سکوت` | `فیلتر` | `خوشامد`]  
▎ `لیست پاکسازی ها`
﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
🏅سازنده: @GirlSudo
🏅کانال ما:
@DelGuardTm]]
end
return helpport_fa..msg_caption
end

end
--------------------------------
return {               
	patterns = {
        "^[!/#](help1)$",
        "^[!/#](help2)$",
        "^[/#!](help3)$",
        "^[!/#](help4)$",
        "^[!/#](help5)$",
        "^[/#!](help6)$",
        "^[/#!](help7)$",
       "^[/#!](rank)$",
       "^[/#!](Rank)$",
    	"^[!/#](weather) (.*)$",
		"^[!/#](calc) (.*)$",
		"^[#!/](time)$",
		"^[#!/](tophoto)$",
		"^[#!/](tosticker)$",
		"^[!/#](tovoice) +(.*)$",
		"^[/!#]([Pp]raytime) (.*)$",
		"^[/!#](praytime)$",
		"^[!/]([Tt]r) ([^%s]+) (.*)$",
		"^[!/]([Ss]hort) (.*)$",
		"^[!/](photo) (.+)$",
		"^[!/](sticker) (.+)$",
      "^(help)$",
      "^(help1)$",
      "^(help2)$",
      "^(help3)$",
      "^(help4)$",
      "^(help5)$",
      "^(help6)$",
      "^(help7)$",
      "^(help8)$",
    	"^(weather) (.*)$",
		"^(calc) (.*)$",
		"^(time)$",
		"^(tophoto)$",
		"^(tosticker)$",
		"^(tovoice) +(.*)$",
		"^([Pp]time) (.*)$",
		"^(ptime)$",
		"^([Tt]r) ([^%s]+) (.*)$",
		"^([Ss]hort) (.*)$",
		"^(photo) (.+)$",
		"^(sticker) (.+)$",
   "^(love) (.+) (.+)$",
   "^[‌/!#](love) (.+) (.+)$",
   "^(لاو) (.+) (.+)$",
      "^(راهنما)$",
      "^(راهنما1)$",
      "^(راهنما2)$",
      "^(راهنما3)$",
      "^(راهنما4)$",
      "^(راهنما5)$",
      "^(راهنما6)$",
      "^(راهنما7)$",
"^(راهنما8)$",
 "^(مقام من)$",
    	"^(دما) (.*)$",
      "^(تاریخ)$",
    	"^(تاریخ) (.*)$",
		"^(ماشین حساب) (.*)$",
		"^(ساعت)$",
		"^(به عکس)$",
		"^(به استیکر)$",
		"^(به صدا) +(.*)$",
		"^(زمان) (.*)$",
		"^(زمان)$",
		"^(ترجمه) ([^%s]+) (.*)$",
		"^(کوتاه) (.*)$",
		"^(عکس) (.+)$",
   "^(gif) (.*)$", 
"^(گیف) (.*)$",
"^بکنش$",
"^بگاش",
"^[/#!](fuck)",
"^fuck",
		"^(استیکر) (.+)$"
		}, 
	run = run,
	}

--#by @DelGuardTm :)
