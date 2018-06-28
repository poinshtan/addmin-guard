--Begin Warn.lua By @SajjadMazini #MeGaPlusTeaM
local function action_by_reply(TM, BD)
local cmd = TM.cmd
if not tonumber(BD.sender_user_id) then return false end
if BD.sender_user_id then
  if cmd == "warn" then
local function warn_cb(TM, BD)
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, BD.id) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.username then
user_name = '@'..check_markdown(BD.username)
else
user_name = check_markdown(BD.first_name)
end
     if BD.id == our_id then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`I can't warn my self`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`من نمیتوانم به خودم اخطار دهم`", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id) and not is_admin1(msg.from.id)then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`You can't warn mods,owners and bot admins`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
   if is_admin1(BD.id)then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`You can't warn bot admins`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`شما نمیتوانید به ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id, TM.chat_id)
redis:hdel(hashwarn, BD.id, '0')
    if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." `"..BD.id.."` `has been kicked because max warning`\n`Number of warn :` "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." `"..BD.id.."` `به دلیل دریافت اخطار بیش از حد اخراج شد`\n`تعداد اخطار ها :` "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, BD.id, tonumber(warnhash) + 1)
    if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.."\n`You've` "..warnhash.." `of` "..max_warn.." `Warns!`", 0, "md")
    else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `شما یک اخطار دریافت کردید`\n`تعداد اخطار های شما :` "..warnhash.."/"..max_warn.."", 0, "md")
    end
  end
end
tdbot_function ({
    _ = "getUser",
    user_id = BD.sender_user_id
  }, warn_cb, {chat_id=BD.chat_id,user_id=BD.sender_user_id,msg=TM.msg})
  end
   if cmd == "unwarn" then
local function unwarn_cb(TM, BD)
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = TM.chat_id..':warn'
local warnhash = redis:hget(hashwarn, BD.id) or 1
if BD.username then
user_name = '@'..check_markdown(BD.username)
else
user_name = check_markdown(BD.first_name)
end
if not redis:hget(hashwarn, BD.id) then
   if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.." `don't have warning`", 0, "md")
   else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `هیچ اخطاری دریافت نکرده`", 0, "md")
    end
  else
redis:hdel(hashwarn, BD.id, '0')
   if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`All warn of` "..user_name.." "..BD.id.." `has been cleaned`", 0, "md")
   else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`تمامی اخطار های` "..user_name.." "..BD.id.." `پاک شدند`", 0, "md")
      end
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = BD.sender_user_id
  }, unwarn_cb, {chat_id=BD.chat_id,user_id=BD.sender_user_id})
    end
else
    if lang then
  return tdbot.sendMessage(BD.chat_id, "", 0, "`کاربر یافت نشد`", 0, "md")
   else
  return tdbot.sendMessage(BD.chat_id, "", 0, "`User Not Found`", 0, "md")
      end
   end
end
local function action_by_username(TM, BD)
if BD.id then
local cmd = TM.cmd
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, BD.id) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
  if cmd == "warn" then
local function warn_cb(TM, BD)
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = TM.chat_id..':warn'
local warnhash = redis:hget(hashwarn, BD.id) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`This user doesn't exists.`", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر موردنظر وجود ندارد`", 0, "md")
     end
 end
if BD.username then
user_name = '@'..check_markdown(BD.username)
else
user_name = check_markdown(BD.first_name)
end
     if BD.id == our_id then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`I can't warn my self`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`من نمیتوانم به خودم اخطار دهم`", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id) and not is_admin1(msg.from.id)then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`You can't warn mods,owners and bot admins`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
   if is_admin1(BD.id)then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`You can't warn bot admins`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`شما نمیتوانید به ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id, TM.chat_id)
redis:hdel(hashwarn, BD.id, '0')
    if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.." `has been kicked because max warning`\n`Number of warn :` "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `به دلیل دریافت اخطار بیش از حد اخراج شد`\n`تعداد اخطار ها :` "..warnhash.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, BD.id, tonumber(warnhash) + 1)
    if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.."\n`You've` "..warnhash.." `of` "..max_warn.." `Warns!`", 0, "md")
    else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `شما یک اخطار دریافت کردید`\n`تعداد اخطار های شما :` "..warnhash.."/"..max_warn.."", 0, "md")
    end
  end
end
tdbot_function ({
    _ = "getUser",
    user_id = BD.id
  }, warn_cb, {chat_id=TM.chat_id,user_id=BD.id,msg=TM.msg})
  end
   if cmd == "unwarn" then
local function unwarn_cb(TM, BD)
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = TM.chat_id..':warn'
local warnhash = redis:hget(hashwarn, BD.id) or 1
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`This user doesn't exists.`", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر موردنظر وجود ندارد`", 0, "md")
     end
 end
if BD.username then
user_name = '@'..check_markdown(BD.username)
else
user_name = check_markdown(BD.first_name)
end
if not redis:hget(hashwarn, BD.id) then
   if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.." `don't have warning`", 0, "md")
   else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `هیچ اخطاری دریافت نکرده`", 0, "md")
    end
  else
redis:hdel(hashwarn, BD.id, '0')
   if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`All warn of` "..user_name.." "..BD.id.." `has been cleaned`", 0, "md")
   else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`تمامی اخطار های` "..user_name.." "..BD.id.." `پاک شدند`", 0, "md")
      end
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = BD.id
  }, unwarn_cb, {chat_id=TM.chat_id,user_id=BD.id,msg=TM.msg})
    end
else
    if lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر یافت نشد`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`User Not Found`", 0, "md")
      end
   end
end
	local function action_by_id(TM, BD)
    if BD.id then
local cmd = TM.cmd
local msg = TM.msg
local hash = "gp_lang:"..TM.chat_id
local lang = redis:get(hash)
local hashwarn = msg.to.id..':warn'
local warnhash = redis:hget(hashwarn, BD.id) or 1
local max_warn = tonumber(redis:get('max_warn:'..TM.chat_id) or 5)
if BD.username then
user_name = '@'..check_markdown(BD.username)
else
user_name = check_markdown(BD.first_name)
end
   if cmd == "warn" then
     if BD.id == our_id then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`I can't warn my self`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`من نمیتوانم به خودم اخطار دهم`", 0, "md")
         end
     end
   if is_mod1(TM.chat_id, BD.id) and not is_admin1(msg.from.id)then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`You can't warn mods,owners and bot admins`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`شما نمیتوانید به مدیران،صاحبان گروه، و ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
   if is_admin1(BD.id)then
  if not lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`You can't warn bot admins`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`شما نمیتوانید به ادمین های ربات اخطار دهید`", 0, "md")
         end
     end
if tonumber(warnhash) == tonumber(max_warn) then
   kick_user(BD.id, TM.chat_id)
redis:hdel(hashwarn, BD.id, '0')
    if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.." `has been kicked because max warning`\n`Number of warn :` "..warnhash.."/"..max_warn.."", 0, "md")
    else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `به دلیل دریافت اخطار بیش از حد اخراج شد`\n`تعداد اخطار ها :` "..hashwarn.."/"..max_warn.."", 0, "md")
    end
else
redis:hset(hashwarn, BD.id, tonumber(warnhash) + 1)
    if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.."\n`You've` "..warnhash.." `of` "..max_warn.." `Warns!`", 0, "md")
    else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `شما یک اخطار دریافت کردید`\n`تعداد اخطار های شما :` "..warnhash.."/"..max_warn.."", 0, "md")
    end
  end
end
   if cmd == "unwarn" then
if not redis:hget(hashwarn, BD.id) then
   if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`User` "..user_name.." "..BD.id.." `don't have warning`", 0, "md")
   else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر` "..user_name.." "..BD.id.." `هیچ اخطاری دریافت نکرده`", 0, "md")
    end
  else
redis:hdel(hashwarn, BD.id, '0')
   if not lang then
    return tdbot.sendMessage(TM.chat_id, "", 0, "`All warn of` "..user_name.." "..BD.id.." `has been cleaned`", 0, "md")
   else
    return tdbot.sendMessage(TM.chat_id, "", 0, "`تمامی اخطار های` "..user_name.." "..BD.id.." `پاک شدند`", 0, "md")
    end
  end
end
else
    if lang then
  return tdbot.sendMessage(TM.chat_id, "", 0, "`کاربر یافت نشد`", 0, "md")
   else
  return tdbot.sendMessage(TM.chat_id, "", 0, "`User Not Found`", 0, "md")
      end
   end
end

local function BeyondTeam(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
		if ((matches[1]:lower() == 'clean' and matches[2] == 'warn' and not Clang) or (matches[1] == "پاکسازی" and matches[2] == 'اخطار' and Clang)) then
			if not is_owner(msg) then
				return
			end
    local hash = msg.to.id..':warn'
    redis:del(hash)
    if not lang then
     return "`All warn of users in this group has been cleaned`"
   else
     return "`تمام اخطار های کاربران این گروه پاک شد`"
		end
  end
		if ((matches[1]:lower() == 'setwarn' and not Clang) or (matches[1] == "تنظیم اخطار" and Clang)) then
			if not is_mod(msg) then
				return
			end
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 20 then
     if not lang then
				return "`Wrong number, range is [1-20]`"
    else
				return "`لطفا عددی بین [1-20] را انتخاب کنید`"
      end
    end
			local warn_max = matches[2]
   redis:set('max_warn:'..msg.to.id, warn_max)
    if not lang then
     return "`Warn maximum has been set to :` [ "..matches[2].." ]"
   else
     return "`حداکثر اخطار تنظیم شد به :` [ "..matches[2].." ]"
		end
  end
if ((matches[1] == "warn" and not Clang) or (matches[1] == "اخطار" and Clang)) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="warn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="warn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="warn"})
      end
   end
if ((matches[1] == "unwarn" and not Clang) or (matches[1] == "حذف اخطار" and Clang)) and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,msg=msg,cmd="unwarn"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and not msg.reply_id then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg=msg,cmd="unwarn"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and not msg.reply_id then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],msg=msg,cmd="unwarn"})
     end
	end
	if ((matches[1] == "warnlist" and not Clang) or (matches[1] == "لیست اخطار" and Clang)) and is_mod(msg) then
		local list = '`Warn Users List:`\n'
		local empty = list
		for k,v in pairs (redis:hkeys(msg.to.id..':warn')) do
			local user_name = redis:get('user_name:'..v)
			local cont = redis:hget(msg.to.id..':warn', v)
			if user_name then
				list = list..k..'- '..check_markdown(user_name)..' ['..v..'] `Warn :` '..(cont - 1)..'\n'
			else
				list = list..k..'- '..v..' `Warn :` '..(cont - 1)..'\n'
			end
		end
		if list == empty then
			return '`WarnList is Empty`'
		else
			return list
		end
		end
end
local function pre_process(msg)
  if tonumber(msg.from.id) ~= 0 then
    local hash = 'user_name:'..msg.from.id
    if msg.from.username then
     user_name = '@'..msg.from.username
  else
     user_name = msg.from.print_name
    end
      redis:set(hash, user_name)
   end
end

return {
  patterns = {
  "^[#!/](warn)$",
  "^[#!/](warn) (.*)$",
  "^[#!/](unwarn)$",
  "^[#!/](unwarn) (.*)$",
  "^[!/#](setwarn) (%d+)$",
  "^[#!/](clean) (warn)$",
  "^[#!/](warnlist)$",
  "^(warn)$",
  "^(warn) (.*)$",
  "^(unwarn)$",
  "^(unwarn) (.*)$",
  "^(setwarn) (%d+)$",
  "^(clean) (warn)$",
  "^(warnlist)$",
  "^(اخطار)$",
  "^(اخطار) (.*)$",
  "^(حذف اخطار)$",
  "^(حذف اخطار) (.*)$",
"^(تنظیم اخطار) (%d+)$",
  "^(پاکسازی) (اخطار)$",
  "^(لیست اخطار)$",

  },
  run = BeyondTeam,
	pre_process = pre_process
}

