local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '`You are not bot admin`'
else
     return '`شما مدیر ربات نمیباشید`'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '️`Group is already added`'
else
return '`️گروه در لیست گروه های مدیریتی ربات هم اکنون موجود است`'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = '┃✓┃',
          lock_tag = '┃✓┃',
          lock_spam = '┃✓┃',
          lock_webpage = '┃✘┃',
          lock_markdown = '┃✘┃',
          flood = '┃✓┃',
          lock_bots = '┃✓┃',
          lock_pin = '┃✘┃',
          welcome = '┃✘┃',
		  lock_join = '┃✘┃',
		  lock_edit = '┃✘┃',
		  lock_arabic = '┃✘┃',
		  lock_mention = '┃✘┃',
		  lock_all = '┃✘┃',
		  num_msg_max = '5',
		  set_char = '40',
		  time_check = '2',
          },
   mutes = {
                  mute_forward = '┃✘┃',
                  mute_audio = '┃✘┃',
                  mute_video = '┃✘┃',
                  mute_contact = '┃✘┃',
                  mute_text = '┃✘┃',
                  mute_photo = '┃✘┃',
                  mute_gif = '┃✘┃',
                  mute_location = '┃✘┃',
                  mute_document = '┃✘┃',
                  mute_sticker = '┃✘┃',
                  mute_voice = '┃✘┃',
                  mute_all = '┃✘┃',
				  mute_keyboard = '┃✘┃',
				  mute_game = '┃✘┃',
				  mute_inline = '┃✘┃',
				  mute_tgservice = '┃✘┃',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '`️Group has been added`️'..msg_caption
else
  return '`️گروه با موفقیت به لیست گروه های مدیریتی ربات افزوده شد`️'..msg_caption
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '`️You are not bot admin`️'
   else
        return '`️شما مدیر ربات نمیباشید`️'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '`️Group is not added`️'
else
    return '`️گروه به لیست گروه های مدیریتی ربات اضافه نشده است`️'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '`️Group has been removed`️'
 else
  return '`️گروه با موفقیت از لیست گروه های مدیریتی ربات حذف شد`️'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "`️Word`️ [ "..word.." ] `️is already filtered`️"
            else
         return "`️کلمه`️ [ "..word.." ] `️از قبل فیلتر بود`️"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "`️Word`️ [ "..word.." ] `️added to filtered words list`️"
            else
         return "`️کلمه`️ [ "..word.." ] `️به لیست کلمات فیلتر شده اضافه شد`️"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "`️Word`️ [ "..word.."] `️removed from filtered words list`️"
       elseif lang then
         return "`️کلمه`️ [ "..word.." ] `️از لیست کلمات فیلتر شده حذف شد`️"
     end
      else
       if not lang then
         return "`️Word`️ [ "..word.." ] `️is not filtered`️"
       elseif lang then
         return "`️کلمه`️ [ "..word.." ] `️از قبل فیلتر نبود`️"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id)] then
  if not lang then
    return "`️Group is not added`️"
 else
    return "`️گروه به لیست گروه های مدیریتی ربات اضافه نشده است`️"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "`️No moderator in this group`️"
else
   return "`️در حال حاضر هیچ مدیری برای گروه انتخاب نشده است`️"
  end
end
if not lang then
   message = '`️List of moderators :`️\n'
else
   message = '`️لیست مدیران گروه :`️\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "`️Group is not added`️"..msg_caption
else
return "`️گروه به لیست گروه های مدیریتی ربات اضافه نشده است`️"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "`️No owner in this group`️"
else
    return "`️در حال حاضر هیچ مالکی برای گروه انتخاب نشده است`️"
  end
end
if not lang then
   message = '`️List of moderators :`️\n'
else
   message = '`️لیست مالکین گروه :`️\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id) then return false end
    if data.sender_user_id then
  if not administration[tostring(data.chat_id)] then
  if not lang then
    return tdbot.sendMessage(data.chat_id, "", 0, "`️Group is not added`️", 0, "md")
else
    return tdbot.sendMessage(data.chat_id, "", 0, "`️گروه به لیست گروه های مدیریتی ربات اضافه نشده است`️", 0, "md")
     end
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️is already in white list`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر` "..user_name.." "..data.id.." `از قبل در لیست سفید بود`", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`User` "..user_name.." "..data.id.." `has been added to white list`", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر` "..user_name.." "..data.id.." `به لیست سفید اضافه شد`", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, setwhitelist_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️is not in white list`️", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل در لیست سفید نبود`️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️has been removed from white list`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از لیست سفید حذف شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, remwhitelist_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is already a group owner`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل صاحب گروه بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is now the group owner`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️به مقام صاحب گروه منتصب شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, owner_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is already a moderator`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل مدیر گروه بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️has been promoted`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️به مقام مدیر گروه منتصب شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, promote_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is not a group owner`️", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️از قبل صاحب گروه نبود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is no longer a group owner`️", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از مقام صاحب گروه برکنار شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, rem_owner_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️is not a moderator`️", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل مدیر گروه نبود`️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️has been demoted`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از مقام مدیر گروه برکنار شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, demote_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdbot.sendMessage(arg.chat_id, "", 0, "`"..data.id.."`", 0, "md")
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, id_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
else
    if lang then
  return tdbot.sendMessage(data.chat_id, "", 0, "`️کاربر یافت نشد`️", 0, "md")
   else
  return tdbot.sendMessage(data.chat_id, "", 0, "`️User Not Found`️", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
    --return tdbot.sendMessage(arg.chat_id, "", 0, serpent.block(data), 0, "html")
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️Group is not added`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️گروه به لیست گروه های مدیریتی ربات اضافه نشده است`️", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id then
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
    --return tdbot.sendMessage(arg.chat_id, "", 0, serpent.block(data), 0, "html")
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️This user doesn't exists.`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر موردنظر وجود ندارد`️", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is already in white list`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل در لیست سفید بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️has been added to white list`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️به لیست سفید اضافه شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, setwhitelist_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️This user doesn't exists.`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر موردنظر وجود ندارد`️", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is not in white list`️", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل در لیست سفید نبود`️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️has been removed from white list`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از لیست سفید حذف شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, remwhitelist_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️This user doesn't exists.`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر موردنظر وجود ندارد`️", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️is already a group owner`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل صاحب گروه بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is now the group owner`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️به مقام صاحب گروه منتصب شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, owner_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`This user doesn't exists.`", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر موردنظر وجود ندارد`", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is already a moderator`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل مدیر گروه بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️has been promoted`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️به مقام مدیر گروه منتصب شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, promote_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️This user doesn't exists.`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر موردنظر وجود ندارد`️", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is not a group owner`️", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل صاحب گروه نبود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "`User` "..user_name.." *"..data.id.."* `is no longer a group owner`", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از مقام صاحب گروه برکنار شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, rem_owner_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️This user doesn't exists.`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر موردنظر وجود ندارد`️", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is not a moderator`️", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل مدیر گروه نبود`️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️has been demoted`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از مقام مدیر گروه برکنار شد`️", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, demote_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "res" then
local function res_cb(arg, data)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️This user doesn't exists.`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر موردنظر وجود ندارد`️", 0, "md")
     end
 end
if data.last_name then
user_name = check_markdown(data.first_name).." "..check_markdown(data.last_name)
else
user_name = check_markdown(data.first_name)
end
    if not lang then
     text = "`️Result For :`️ @"..check_markdown(data.username).."\n_Name :_ "..user_name.."\n`️ID :`️ `"..data.id.."`"
      else
     text = "`️اطلاعات برای :`️ @"..check_markdown(data.username).."\n`️نام :`️ "..user_name.."\n`️ایدی :`️ `"..data.id.."`"
  end
    return tdbot.sendMessage(arg.chat_id, "", 0, text, 0, "md")
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, res_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر یافت نشد`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️User Not Found`️", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdbot.sendMessage(data.chat_id, "", 0, "`️Group is not added`️", 0, "md")
else
    return tdbot.sendMessage(data.chat_id, "", 0, "`️گروه به لیست گروه های مدیریتی ربات اضافه نشده است`️", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id then
if data.first_name then
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is already in white list`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل در لیست سفید بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️has been added to white list`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️به لیست سفید اضافه شد`️", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️is not in white list`️", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل در لیست سفید نبود`️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️has been removed from white list`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از لیست سفید حذف شد`️", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." is already a group owner`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل صاحب گروه بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is now the group owner`️", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️به مقام صاحب گروه منتصب شد`️", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is already a moderator`️", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر` ️"..user_name.." "..data.id.." `️از قبل مدیر گروه بود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️has been promoted`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️به مقام مدیر گروه منتصب شد`️", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "`️User`️ "..user_name.." "..data.id.." `️is not a `️group owner`️", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل صاحب گروه نبود`️", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is no longer a group owner`️", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از مقام صاحب گروه برکنار شد`️", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️User` ️"..user_name.." "..data.id.." `️is not a moderator`️", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️ "..user_name.." "..data.id.." `️از قبل مدیر گروه نبود`️", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "User "..user_name.." "..data.id.." `️has been ️demoted`️", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`️کاربر`️"..user_name.." `️"..data.id.." `️از مقام مدیر گروه برکنار شد`️", 0, "md")
   end
end
    if cmd == "whois" then
if data.username then
username = '@'..check_markdown(data.username)
else
if not lang then
username = '`not found`'
 else
username = '`ندارد`'
  end
end
     if not lang then
       return tdbot.sendMessage(arg.chat_id, "", 0, 'Info for [ '..data.id..' ] :\nUserName : '..username..'\nName : '..check_markdown(data.first_name), 0, "md")
   else
       return tdbot.sendMessage(arg.chat_id, "", 0, 'اطلاعات برای [ '..data.id..' ] :\nیوزرنیم : '..username..'\nنام : '..check_markdown(data.first_name), 0, "md")
      end
   end
 else
    if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`User not founded`", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر یافت نشد`", 0, "md")
    end
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`کاربر یافت نشد`", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`User Not Found`", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "┃✓┃" then
if not lang then
 return "Link Posting Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock link`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال لینک در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن لینک`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
data[tostring(target)]["settings"]["lock_link"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Link Posting Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock link`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال لینک در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن لینک`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "┃✘┃" then
if not lang then
return "Link Posting Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock link`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
return "ارسال لینک در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل لینک`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_link"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Link Posting Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock link`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "ارسال لینک در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل لینک`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "┃✓┃" then
if not lang then
 return "Tag Posting Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock tag`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال تگ در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن تگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Tag Posting Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock tag`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال تگ در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن تگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "┃✘┃" then
if not lang then
return "Tag Posting Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock tag`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ارسال تگ در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل تگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Tag Posting Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock tag`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ارسال تگ در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل تگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "┃✓┃" then
if not lang then
 return "Mention Posting Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock mention`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال فراخوانی افراد هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن فراخوانی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "┃✓┃"
save_data(_config.moderation.data, data)
if not lang then 
 return "Mention Posting Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock mention`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else 
 return "ارسال فراخوانی افراد در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن فراخوانی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "┃✘┃" then
if not lang then
return "Mention Posting Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock mention`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ارسال فراخوانی افراد در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل فراخوانی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Mention Posting Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Llocked: 『`lock mention`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ارسال فراخوانی افراد در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل فراخوانی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "┃✓┃" then
if not lang then
 return "Arabic Posting Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock arabic`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال کلمات عربی در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن عربی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Arabic Posting Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock arabic`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال کلمات عربی در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن عربی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "┃✘┃" then
if not lang then
return "Arabic Posting Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock arabic`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ارسال کلمات عربی در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل عربی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Arabic Posting Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock arabic`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ارسال کلمات عربی در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل عربی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "┃✓┃" then
if not lang then
 return "Editing Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock edit`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ویرایش پیام هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن ویرایش`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Editing Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock edit`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ویرایش پیام در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن ویرایش`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "┃✘┃" then
if not lang then
return "Editing Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock edit`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ویرایش پیام در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل ویرایش`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Editing Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock edit`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ویرایش پیام در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل ویرایش`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "┃✓┃" then
if not lang then
 return "Spam Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock spam`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال هرزنامه در گروه هم اکنون ممنوع است`\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن اسپم`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Spam Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock spam`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال هرزنامه در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن اسپم`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "┃✘┃" then
if not lang then
return "Spam Posting Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock spam`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
 return "ارسال هرزنامه در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل اسپم`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "┃✘┃" 
save_data(_config.moderation.data, data)
if not lang then 
return "Spam Posting Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock spam`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
 return "ارسال هرزنامه در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل اسپم`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "┃✓┃" then
if not lang then
 return "Flooding Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`unlock flood`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال پیام مکرر در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن فلود`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["flood"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Flooding Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock flood`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال پیام مکرر در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن فلود`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "┃✘┃" then
if not lang then
return "Flooding Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock flood`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ارسال پیام مکرر در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل فلود`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["flood"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Flooding Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock flood`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ارسال پیام مکرر در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل فلود`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "┃✓┃" then
if not lang then
 return "Bots Protection Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock bots`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "محافظت از گروه در برابر ربات ها هم اکنون فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن ربات`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Bots Protection Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock bots`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "محافظت از گروه در برابر ربات ها فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن ربات`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "┃✘┃" then
if not lang then
return "Bots Protection Is Not Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock bots`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "محافظت از گروه در برابر ربات ها غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل ربات`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Bots Protection Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock bots`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "محافظت از گروه در برابر ربات ها غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل ربات`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "┃✓┃" then
if not lang then
 return "Lock Join Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock join`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ورود به گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن جوین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_join"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Lock Join Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock join`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ورود به گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن جوین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "┃✘┃" then
if not lang then
return "Lock Join Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock join`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ورود به گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل جوین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_join"] = "┃✘┃"
save_data(_config.moderation.data, data) 
if not lang then
return "Lock Join Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock join`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ورود به گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل جوین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "┃✓┃" then
if not lang then 
 return "Markdown Posting Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock markdown`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال پیام های دارای فونت در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن فونت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Markdown Posting Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock markdown`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال پیام های دارای فونت در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن فونت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "┃✘┃" then
if not lang then
return "Markdown Posting Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock markdown`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
return "ارسال پیام های دارای فونت در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل فونت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "┃✘┃" save_data(_config.moderation.data, data) 
if not lang then
return "Markdown Posting Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock markdown`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "ارسال پیام های دارای فونت در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل فونت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "┃✓┃" then
if not lang then
 return "Webpage Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock webpage`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "ارسال صفحات وب در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن وب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Webpage Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock webpage`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "ارسال صفحات وب در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن وب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "┃✘┃" then
if not lang then
return "Webpage Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock webpage`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "ارسال صفحات وب در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل وب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "┃✘┃"
save_data(_config.moderation.data, data) 
if not lang then
return "Webpage Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock webpage`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "ارسال صفحات وب در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل وب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "┃✓┃" then
if not lang then
 return "Pinned Message Is Already Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock pin`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "سنجاق کردن پیام در گروه هم اکنون ممنوع است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن سنجاق`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "┃✓┃"
save_data(_config.moderation.data, data) 
if not lang then
 return "Pinned Message Has Been Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unlocked: 『`unlock pin`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "سنجاق کردن پیام در گروه ممنوع شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`بازکردن سنجاق`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "┃✘┃" then
if not lang then
return "Pinned Message Is Not Locked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock pin`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "سنجاق کردن پیام در گروه ممنوع نمیباشد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل سنجاق`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "┃✘┃"
save_data(_config.moderation.data, data) 
if not lang then
return "Pinned Message Has Been Unlocked\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Locked: 『`lock pin`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "سنجاق کردن پیام در گروه آزاد شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`قفل سنجاق`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "`You're Not Moderator`"
else
  return "`تو هیچ مقامی در من نداری پس نزن`"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "┃✓┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "┃✓┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "┃✘┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "┃✘┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "┃✘┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "┃✓┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "┃✓┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "┃✓┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "┃✘┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "┃✘┃"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "┃✘┃"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "┃✘┃"		
 end
 end
 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "┃✘┃"		
 end
 end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
if not lang then

local settings = data[tostring(target)]["settings"] 
 text = "*addmin guard Group Lock Settings:*\n\n`edit :` *"..settings.lock_edit.."*\n`links :` *"..settings.lock_link.."*\n`tags :` *"..settings.lock_tag.."*\n`join :` *"..settings.lock_join.."*\n`flood :` *"..settings.flood.."*\n`spam :` *"..settings.lock_spam.."*\n`mention :` *"..settings.lock_mention.."*\n`arabic :` *"..settings.lock_arabic.."*\n`webpage :` *"..settings.lock_webpage.."* \n`markdown :` *"..settings.lock_markdown.."* \n`welcome :` *"..settings.welcome.."*\n`pin :` *"..settings.lock_pin.."* \n`bots :` *"..settings.lock_bots.."*\n`Flood sensitivity :` *"..NUM_MSG_MAX.."*\n`Character sensitivity :` *"..SETCHAR.."*\n`Flood check time :` *"..TIME_CHECK.."*\n*____________________*\n`Expire Date :` *"..expire_date.."*\n`Bot channel:` @DelGuardTm\n`Group Language :` 🎗EN"
else
local settings = data[tostring(target)]["settings"] 
 text = "_️تنظیمات قفلی ربات\nادمین گارد در گروه:_\n\n`ویرایش :` *"..settings.lock_edit.."*\n`لینک :` *"..settings.lock_link.."*\n`ورود :` *"..settings.lock_join.."*\n`تگ :` *"..settings.lock_tag.."*\n`فلود :` *"..settings.flood.."*\n`اسپم :` *"..settings.lock_spam.."*\n`فراخوانی :` *"..settings.lock_mention.."*\n`عربی :` *"..settings.lock_arabic.."*\n`وب :` *"..settings.lock_webpage.."*\n`فونت :` *"..settings.lock_markdown.."*\n`خوشامد :` *"..settings.welcome.."*\n`سنجاق :` *"..settings.lock_pin.."*\n`ربات :` *"..settings.lock_bots.."*\n`حداکثر پیام مکرر :` *"..NUM_MSG_MAX.."*\n`حداکثر حروف مجاز :` *"..SETCHAR.."*\n`زمان بررسی پیام های مکرر :` *"..TIME_CHECK.."*\n*____________________*\n`تاریخ انقضا :` *"..expire_date.."*\n`کانال ما:` @DelGuardTm\n`زبان سوپرگروه :` 🎗FA"
end
return text
end
--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "`You're Not Moderator`" 
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "┃✓┃" then 
if not lang then
return "Mute Group Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute group`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن گروه فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا گروه`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "┃✓┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Group Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute group`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن گروه فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا گروه`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "`You're Not Moderator`" 
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "┃✘┃" then 
if not lang then
return "Mute Group Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute group`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن گروه غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا گروه`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Group Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute group`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن گروه غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا گروه`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "┃✓┃" then
if not lang then
 return "Mute Gif Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute gif`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن تصاویر متحرک فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا گیف`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "Mute Gif Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute gif`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن تصاویر متحرک فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا گیف`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "┃✘┃" then
if not lang then
return "Mute Gif Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute gif`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن تصاویر متحرک غیر فعال بود\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا گیف`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Gif Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute gif`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن تصاویر متحرک غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا گیف`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "┃✓┃" then
if not lang then
 return "Mute Game Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute game`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن بازی های تحت وب فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا بازی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_game"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Game Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute game`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن بازی های تحت وب فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا بازی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "┃✘┃" then
if not lang then
return "Mute Game Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute game`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن بازی های تحت وب غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا بازی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_game"] = "┃✘┃"
 save_data(_config.moderation.data, data)
if not lang then 
return "Mute Game Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute game`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن بازی های تحت وب غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا بازی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "┃✓┃" then
if not lang then
 return "Mute Inline Is Already Enabled ⇏ Is Unmuted: 『`unmute inline`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن کیبورد شیشه ای فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا اینلاین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Inline Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute inline`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن کیبورد شیشه ای فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا اینلاین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "┃✘┃" then
if not lang then
return "Mute Inline Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute inline`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن کیبورد شیشه ای غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا اینلاین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Inline Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute inline`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن کیبورد شیشه ای غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدد اینلاین`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "┃✓┃" then
if not lang then
 return "Mute Text Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute text`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن متن فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا متن`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_text"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Text Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute text`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن متن فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا متن`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "┃✘┃" then
if not lang then
return "Mute Text Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute text`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
return "بیصدا کردن متن غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا متن`』\n↫توسط : @"..check_markdown(msg.from.username or "---").."" 
end
else 
data[tostring(target)]["mutes"]["mute_text"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Text Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute text`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن متن غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا متن`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "┃✓┃" then
if not lang then
 return "Mute Photo Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute photo`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن عکس فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا عکس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Photo Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute photo`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن عکس فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا عکس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "┃✘┃" then
if not lang then
return "Mute Photo Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute photo`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن عکس غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا عکس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Photo Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute photo`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن عکس غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا عکس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "┃✓┃" then
if not lang then
 return "Mute Video Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute video`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن فیلم فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا ویدیو`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_video"] = "┃✓┃" 
save_data(_config.moderation.data, data)
if not lang then 
 return "Mute Video Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute    video`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن فیلم فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا ویدیو`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "┃✘┃" then
if not lang then
return "Mute Video Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute video`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن فیلم غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا ویدیو`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_video"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Video Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute video`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن فیلم غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا ویدیو`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Video_Note-------------------
local function mute_video_note(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_video_note = data[tostring(target)]["mutes"]["mute_video_note"] 
if mute_video == "┃✓┃" then
if not lang then
 return "Mute Video Note Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute videonote`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن فیلم سلفی فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا فیلم سلفی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_video_note"] = "┃✓┃" 
save_data(_config.moderation.data, data)
if not lang then 
 return "Mute Video Note Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute  videonote`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن فیلم سلفی فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا فیلم سلفی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_video_note(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_video_note = data[tostring(target)]["mutes"]["mute_video_note"]
 if mute_video == "┃✘┃" then
if not lang then
return "Mute Video Note Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute vedionote`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن فیلم سلفی غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدد فیلم سلفی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_video_note"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Video Note Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute videonote`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن فیلم سلفی غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا فیلم سلفی`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "┃✓┃" then
if not lang then
 return "Mute Audio Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute audio`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن آهنگ فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا آهنگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Audio Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute audio`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else 
return "بیصدا کردن آهنگ فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا آهنگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "┃✘┃" then
if not lang then
return "Mute Audio Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute videonote`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن آهنک غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا آهنگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = "┃✘┃"
 save_data(_config.moderation.data, data)
if not lang then 
return "Mute Audio Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute videonote`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "بیصدا کردن آهنگ غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا آهنگ`』\n↫توسط : @"..check_markdown(msg.from.username or "---").."" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "┃✓┃" then
if not lang then
 return "Mute Voice Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute  voice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن صدا فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا ویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Voice Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute voice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن صدا فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا ویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "┃✘┃" then
if not lang then
return "Mute Voice Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute voice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن صدا غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا ویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = "┃✘┃"
 save_data(_config.moderation.data, data)
if not lang then 
return "Mute Voice Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute voice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن صدا غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا ویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "┃✓┃" then
if not lang then
 return "Mute Sticker Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute sticker`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن استیکر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا استیکر`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Sticker Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute sticker`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن استیکر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا استیکر`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end 
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "┃✘┃" then
if not lang then
return "Mute Sticker Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute sticker`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن استیکر غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا استیکر`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = "┃✘┃"
 save_data(_config.moderation.data, data)
if not lang then 
return "Mute Sticker Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute sticker`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "بیصدا کردن استیکر غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا استیکر`』\n↫توسط  @"..check_markdown(msg.from.username or "---")..""
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "┃✓┃" then
if not lang then
 return "Mute Contact Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute contact`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن مخاطب فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا مخاطب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Contact Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute contact`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن مخاطب فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا مخاطب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "┃✘┃" then
if not lang then
return "Mute Contact Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute contact`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن مخاطب غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا مخاطب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Contact Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute contact`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن مخاطب غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا مخاطب`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "┃✓┃" then
if not lang then
 return "Mute Forward Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute forward`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن فوروارد فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا فوروارد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Forward Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute forward`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن فوروارد فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا فوروارد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "┃✘┃" then
if not lang then
return "Mute Forward Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute forward`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
return "بیصدا کردن فوروارد غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا فوروارد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = "┃✘┃"
 save_data(_config.moderation.data, data)
if not lang then 
return "Mute Forward Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute forward`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن فوروارد غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا فوروارد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "┃✓┃" then
if not lang then
 return "Mute Location Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute location`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن موقعیت فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا موقعیت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_location"] = "┃✓┃" 
save_data(_config.moderation.data, data)
if not lang then
 return "Mute Location Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute location`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن موقعیت فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا موقعیت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "┃✘┃" then
if not lang then
return "Mute Location Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute location`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن موقعیت غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا موقعیت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_location"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Location Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute location`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن موقعیت غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا موقعیت`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "┃✓┃" then
if not lang then
 return "Mute Document Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute document`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن فایل فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا فایل`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_document"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Document‌ Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute document`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
 return "بیصدا کردن فایل فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا فایل`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "`تو هیچ مقامی در من نداری پس نزن`"
end
end 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "┃✘┃" then
if not lang then
return "Mute Document Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute document`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
elseif lang then
return "بیصدا کردن فایل غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا فایل`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else 
data[tostring(target)]["mutes"]["mute_document"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Document Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute document`』\n↬submitted by : @"..check_markdown(msg.from.username or "---").."" 
else
return "بیصدا کردن فایل غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا فایل`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "┃✓┃" then
if not lang then
 return "Mute TgService Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute tgservice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن خدمات تلگرام فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا سرویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute TgService Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute tgservice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "بیصدا کردن خدمات تلگرام فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا سرویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "شما مدیر گروه نیستید"
end 
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "┃✘┃" then
if not lang then
return "Mute TgService Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute tgservice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
return "بیصدا کردن خدمات تلگرام غیر فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا سرویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute TgService Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute tgservice`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "بیصدا کردن خدمات تلگرام غیر فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا سرویس`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "`You're Not Moderator`"
else
 return "`تو هیچ مقامی در من نداری پس نزن`"
end
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "┃✓┃" then
if not lang then
 return "Mute Keyboard Is Already Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute keyboard`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
 return "بیصدا کردن صفحه کلید فعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا کیبورد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "┃✓┃" 
save_data(_config.moderation.data, data) 
if not lang then
 return "Mute Keyboard Has Been Enabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Unmuted: 『`unmute keyboard`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "بیصدا کردن صفحه کلید فعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nغیرفعال سازی:『`باصدا کیبورد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "`You're Not Moderator`"
else
return "شما مدیر گروه نیستید"
end 
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "┃✘┃" then
if not lang then
return "Mute Keyboard Is Already Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute keyboard`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
elseif lang then
return "بیصدا کردن صفحه کلید غیرفعال است\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا کیبورد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "┃✘┃"
 save_data(_config.moderation.data, data) 
if not lang then
return "Mute Keyboard Has Been Disabled\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nIs Muted: 『`mute keyboard`』\n↬submitted by : @"..check_markdown(msg.from.username or "---")..""
else
return "بیصدا کردن صفحه کلید غیرفعال شد\n﹍﹍﹍﹍﹍﹍﹍﹍﹍﹍\nفعال سازی:『`بیصدا کیبورد`』\n↫توسط : @"..check_markdown(msg.from.username or "---")..""
end 
end
end
----------MuteList---------
local function mutes(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "`You're Not Moderator`"	
else
 return "شما مدیر گروه نیستید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_all"] then			
data[tostring(target)]["mutes"]["mute_all"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video_note"] then			
data[tostring(target)]["mutes"]["mute_video_note"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "┃✘┃"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "┃✘┃"		
end
end
if not lang then
local mutes = data[tostring(target)]["mutes"] 
 text = "*⚡addmin guard Group Mute List:*\n`group :` *"..mutes.mute_all.."*\n`gif :` *"..mutes.mute_gif.."*\n`text :` *"..mutes.mute_text.."*\n`inline :` *"..mutes.mute_inline.."*\n`game :` *"..mutes.mute_game.."*\n`photo :` *"..mutes.mute_photo.."*\n`video :` *"..mutes.mute_video.."*\n`audio :` *"..mutes.mute_audio.."*\n`voice :` *"..mutes.mute_voice.."*\n`sticker :` *"..mutes.mute_sticker.."*\n`contact :` *"..mutes.mute_contact.."*\n`forward :` *"..mutes.mute_forward.."*\n`location :` *"..mutes.mute_location.."*\n`document :` *"..mutes.mute_document.."*\n`tgService :` *"..mutes.mute_tgservice.."*\n`keyboard :` *"..mutes.mute_keyboard.."*\n`video note :` *"..mutes.mute_video_note.."*\n *____________________*\n`Bot channel:` @DelGuardTm\n`Group Language :` 🎗EN"
else
local mutes = data[tostring(target)]["mutes"] 
 text = " _⚡️تنظیمات رسانه ربات ادمین گارد در گروه:_\n\n`گروه : ` *"..mutes.mute_all.."*\n`گیف :` *"..mutes.mute_gif.."*\n`متن :` *"..mutes.mute_text.."*\n`اینلاین :` *"..mutes.mute_inline.."*\n`بازی :` *"..mutes.mute_game.."*\n`عکس :` *"..mutes.mute_photo.."*\n`فیلم :` *"..mutes.mute_video.."*\n`آهنگ :` *"..mutes.mute_audio.."*\n`ویس :` *"..mutes.mute_voice.."*\n`استیکر :` *"..mutes.mute_sticker.."*\n`مخاطب :` *"..mutes.mute_contact.."*\n`فوروارد :` *"..mutes.mute_forward.."*\n`موقعیت :` *"..mutes.mute_location.."*\n`فایل :` *"..mutes.mute_document.."*\n`سرویس :` *"..mutes.mute_tgservice.."*\n`کیبورد :` *"..mutes.mute_keyboard.."*\n`فیلم سلفی :` *"..mutes.mute_video_note.."*\n*____________________*\n`کانال ما`: @DelGuardTm\n`زبان سوپرگروه :` 🎗FA"
end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
local data = load_data(_config.moderation.data)
local chat = msg.chat_id
local user = msg.sender_user_id
-- if msg.to.type ~= 'pv' then
if ((matches[1] == "install" and not Clang) or (matches[1] == "نصب" and Clang)) then
return modadd(msg)
end
if ((matches[1] == "uninstall" and not Clang) or (matches[1] == "لغو نصب" and Clang)) then
return modrem(msg)
end
if not data[tostring(msg.chat_id)] then return end
if (matches[1] == "id" and not Clang) or (matches[1] == "ایدی" and Clang) then
print('OK')
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
-- vardump(data)
   if data.photos[0] then
       if not lang then
        tdbot.sendPhoto(msg.to.id, msg.id, data.photos[0].sizes[1].photo.persistent_id, 0, {}, 0, 0, '○Gp ID : '..msg.to.id..'\n‌●UserName : '..msg.from.id, 0, 0, 1, nil, dl_cb, nil)
       elseif lang then
        tdbot.sendPhoto(msg.to.id, msg.id, data.photos[0].sizes[1].photo.persistent_id, 0, {}, 0, 0, '○شناسه گروه : '..msg.to.id..'\n●شناسه شما : '..msg.from.id, 0, 0, 1, nil, dl_cb, nil)
     end
   else
       if not lang then
      tdbot.sendMessage(msg.to.id, msg.id, 1, "`You Have Not Profile Photo...!`\n\n○Gp ID : `"..msg.to.id.."`\n●UserName : `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdbot.sendMessage(msg.to.id, msg.id, 1, "شما هیچ عکسی ندارید...!\n\n○شناسه گروه : `"..msg.to.id.."`\n●شناسه شما : `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   assert(tdbot_function ({
    _ = "getUserProfilePhotos",
    user_id = msg.sender_user_id,
    offset = 0,
    limit = 1
  }, getpro, nil))
end
if tonumber(msg.reply_to_message_id) ~= 0 and not matches[2] and is_mod(msg) then
    assert(tdbot_function ({
      _ = "getMessage",
      chat_id = msg.chat_id,
      message_id = msg.reply_to_message_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"}))
  end
if matches[2] and is_mod(msg) then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if ((matches[1] == "pin" and not Clang) or (matches[1] == "سنجاق" and Clang)) and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '┃✓┃' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
if not lang then
return "`Message Has Been Pinned`"
elseif lang then
return "`پیام سجاق شد`"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == '┃✘┃' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
if not lang then
return "`Message Has Been Pinned`"
elseif lang then
return "`پیام سجاق شد`"
end
end
end
if ((matches[1] == 'unpin' and not Clang) or (matches[1] == "حذف سنجاق" and Clang)) and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == '┃✓┃' then
if is_owner(msg) then
tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
if not lang then
return "`Pin message has been unpinned`"
elseif lang then
return "`پیام سنجاق شده پاک شد`"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == '┃✘┃' then
tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
if not lang then
return "`Pin message has been unpinned`"
elseif lang then
return "`پیام سنجاق شده پاک شد`"
end
end
end
if ((matches[1]:lower() == "vip" and not Clang) or (matches[1] == "ویژه" and Clang)) and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if ((matches[1]:lower() == "vip" and not Clang) or (matches[1] == "ویژه" and Clang)) and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if ((matches[1] == "setowner" and not Clang) or (matches[1] == 'صاحب' and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if ((matches[1] == "remowner" and not Clang) or (matches[1] == "حذف صاحب" and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if ((matches[1] == "promote" and not Clang) or (matches[1] == "ترفیع" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if ((matches[1] == "demote" and not Clang) or (matches[1] == "تنزل" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if ((matches[1] == "lock" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "لینک" and Clang)) then
return lock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "تگ" and Clang)) then
return lock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "فراخوانی" and Clang)) then
return lock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "عربی" and Clang)) then
return lock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "ویرایش" and Clang)) then
return lock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "اسپم" and Clang)) then
return lock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "فلود" and Clang)) then
return lock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "ربات" and Clang)) then
return lock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "فونت" and Clang)) then
return lock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "وب" and Clang)) then
return lock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "سنجاق" and Clang)) and is_owner(msg) then
return lock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "جوین" and Clang)) then
return lock_join(msg, data, target)
end
end

if ((matches[1] == "unlock" and not Clang) or (matches[1] == "بازکردن" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "لینک" and Clang)) then
return unlock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "تگ" and Clang)) then
return unlock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "فراخوانی" and Clang)) then
return unlock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "عربی" and Clang)) then
return unlock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "ویرایش" and Clang)) then
return unlock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "اسپم" and Clang)) then
return unlock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "فلود" and Clang)) then
return unlock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "ربات" and Clang)) then
return unlock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "فونت" and Clang)) then
return unlock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "وب" and Clang)) then
return unlock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "سنجاق" and Clang)) and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "جوین" and Clang)) then
return unlock_join(msg, data, target)
end
end
if ((matches[1] == "mute" and not Clang) or (matches[1] == "بیصدا" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "group" and not Clang) or (matches[2] == "گروه" and Clang)) then
return mute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "گیف" and Clang)) then
return mute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "متن" and Clang)) then
return mute_text(msg ,data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "عکس" and Clang)) then
return mute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "ویدیو" and Clang)) then
return mute_video(msg ,data, target)
end
if ((matches[2] == "video_note" and not Clang) or (matches[2] == "فیلم سلفی" and Clang)) then
return mute_video_note(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "اهنگ" and Clang)) then
return mute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "ویس" and Clang)) then
return mute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "استیکر" and Clang)) then
return mute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "مخاطب" and Clang)) then
return mute_contact(msg ,data, target)
end
if ((matches[2] == "forward" and not Clang) or (matches[2] == "فوروارد" and Clang)) then
return mute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "موقعیت" and Clang)) then
return mute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "فایل" and Clang)) then
return mute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "سرویس" and Clang)) then
return mute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "اینلاین" and Clang)) then
return mute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "بازی" and Clang)) then
return mute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "کیبورد" and Clang)) then
return mute_keyboard(msg ,data, target)
end
end

if ((matches[1] == "unmute" and not Clang) or (matches[1] == "باصدا" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "group" and not Clang) or (matches[2] == "گروه" and Clang)) then
return unmute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "گیف" and Clang)) then
return unmute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "متن" and Clang)) then
return unmute_text(msg, data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "عکس" and Clang)) then
return unmute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "ویدیو" and Clang)) then
return unmute_video(msg ,data, target)
end
if ((matches[2] == "video_note" and not Clang) or (matches[2] == "فیلم سلفی" and Clang)) then
return unmute_video_note(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "اهنگ" and Clang)) then
return unmute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "ویس" and Clang)) then
return unmute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "استیکر" and Clang)) then
return unmute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "مخاطب" and Clang)) then
return unmute_contact(msg ,data, target)
end
if ((matches[2] == "forward" and not Clang) or (matches[2] == "فوروارد" and Clang)) then
return unmute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "موقعیت" and Clang)) then
return unmute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "فایل" and Clang)) then
return unmute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "سرویس" and Clang)) then
return unmute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "اینلاین" and Clang)) then
return unmute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "بازی" and Clang)) then
return unmute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "کیبورد" and Clang)) then
return unmute_keyboard(msg ,data, target)
end
end
if ((matches[1] == "gpinfo" and not Clang) or (matches[1] == "اطلاعات گروه" and Clang)) and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "`‌Group Info :`‌\n`‌Admin Count :`‌ *"..data.administrator_count.."*\n`‌Member Count :`‌ *"..data.member_count.."*\n`‌Kicked Count :`‌ *"..data.kicked_count.."*\n`‌Group ID :`‌ *"..data.channel.id.."*"
-- print(serpent.block(data))
elseif lang then
ginfo = "`‌اطلاعات گروه :`‌\n`‌تعداد مدیران :`‌ *"..data.administrator_count.."*\n`‌تعداد اعضا :`‌ *"..data.member_count.."*\n`‌تعداد اعضای حذف شده :`‌ *"..data.kicked_count.."*\n`‌شناسه گروه :`‌ *"..data.channel.id.."*"
-- print(serpent.block(data))
end
        tdbot.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdbot.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if ((matches[1] == 'newlink' and not Clang) or (matches[1] == "لینک جدید" and Clang)) and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "`‌Bot is not group creator`‌\n`‌set a link for group with using`‌ 《`‌setlink`‌》"..msg_caption, 1, 'md')
       elseif lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "`‌ربات سازنده گروه نیست`‌\n`‌با دستور`‌ 《`‌setlink`‌》 `‌لینک جدیدی برای گروه ثبت کنید`‌"..msg_caption, 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "`Newlink Created`", 1, 'md')
        elseif lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "`لینک جدید ساخته شد`", 1, 'md')
            end
				end
			end
 tdbot.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if ((matches[1] == 'setlink' and not Clang) or (matches[1] == "تنظیم لینک" and Clang)) and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '`Please send the new group link now`'
    else 
         return '`لطفا لینک گروه خود را ارسال کنید`'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "`‌Newlink has been set`‌"
           else
           return "`‌لینک جدید ذخیره شد`‌"
		 	end
       end
		end
    if ((matches[1] == 'link' and not Clang) or (matches[1] == "لینک" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "`‌First create a link for group with using`‌ 《`‌newlink`‌》\n`‌If bot not group creator set a link with using`‌ 《`‌setlink`‌》"
     else
        return "`‌ابتدا با دستور`‌ 《`‌newlink`‌》 `‌لینک جدیدی برای گروه بسازید`‌\n`‌و اگر ربات سازنده گروه نیس با دستور`‌ 《`‌setlink`‌》`‌ لینک جدیدی برای گروه ثبت کنید`‌"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp..msg_caption
     else
      text = "<b>‌‌لینک گروه :‌</b>\n"..linkgp..msg_caption
         end
        return tdbot.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if ((matches[1] == 'linkpv' and not Clang) or (matches[1] == "لینک خصوصی" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "`First create a link for group with using`《`newlink`》\n`If bot not group creator set a link with using`《`setlink`》"
     else
        return "`ابتدا با دستور `《`newlink`》 `لینک جدیدی برای گروه بسازید`\n`و اگر ربات سازنده گروه نیس با دستور` 《`setlink`》 `لینک جدیدی برای گروه ثبت کنید`"
      end
      end
     if not lang then
     tdbot.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
     else
      tdbot.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
         end
      if not lang then
        return "`Group Link Was Send In Your Private Message`"
       else
        return "`لینک گروه به چت خصوصی شما ارسال شد`"
        end
     end
  if ((matches[1] == "setrules" and not Clang) or (matches[1] == "تنظیم قوانین" and Clang)) and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "`Group rules has been set`"
   else 
  return "`قوانین گروه ثبت شد`"
   end
  end
  if ((matches[1] == "rules" and not Clang) or (matches[1] == "قوانین" and Clang)) then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "`ℹ️ The Default Rules :`\n`1⃣ No Flood.`\n`2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.`\n`5⃣ Forbidden any racist, sexual, homophobic or gore content.`\n`➡️ Repeated failure to comply with these rules will cause ban.`"..msg_caption
    elseif lang then
       rules = "`ℹ️ قوانین پپیشفرض:`\n`1⃣ ارسال پیام مکرر ممنوع.`\n`2⃣ اسپم ممنوع.`\n`3⃣ تبلیغ ممنوع.`\n`4⃣ سعی کنید از موضوع خارج نشید.`\n`5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .`\n`➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.`"..msg_caption
 end
        else
     rules = "`Group Rules :`\n"..data[tostring(chat)]['rules']
      end
    return rules
  end

if ((matches[1] == "res" and not Clang) or (matches[1] == "کاربری" and Clang)) and matches[2] and is_mod(msg) then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if ((matches[1] == "whois" and not Clang) or (matches[1] == "شناسه" and Clang)) and matches[2] and is_mod(msg) then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if ((matches[1]:lower() == 'setchar' and not Clang) or (matches[1] == "حداکثر حروف مجاز" and Clang)) then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "`Character sensitivity has been set to :` *[ "..matches[2].." ]*"
   else
     return "`حداکثر حروف مجاز در پیام تنظیم شد به :` *[ "..matches[2].." ]*"
		end
  end
  if ((matches[1]:lower() == 'setflood' and not Clang) or (matches[1] == "تنظیم پیام مکرر" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "`Wrong number, range is` [2-50]"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "`Group flood sensitivity has been set to :` *[ "..matches[2].." ]*"
    else
    return '`محدودیت پیام مکرر به *'..tonumber(matches[2])..'* تنظیم شد.`'
    end
       end
  if ((matches[1]:lower() == 'setfloodtime' and not Clang) or (matches[1] == "تنظیم زمان بررسی" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "`Wrong number, range is` [2-10]"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "`Group flood check time has been set to : *[ "..matches[2].." ]*"
    else
    return "`حداکثر زمان بررسی پیام های مکرر تنظیم شد به :` *[ "..matches[2].." ]*"
    end
       end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "پاکسازی" and Clang)) and is_owner(msg) then
			if ((matches[2] == 'mods' and not Clang) or (matches[2] == "مدیران" and Clang)) then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "`No moderators in this group`"
             else
                return "`هیچ مدیری برای گروه انتخاب نشده است`"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "`All moderators has been demoted`"
          else
            return "`تمام مدیران گروه تنزیل مقام شدند`"
			end
         end
			if ((matches[2] == 'filters' and not Clang) or (matches[2] == "فیلتر" and Clang)) then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "`Filtered words list is empty`"
         else
					return "`لیست کلمات فیلتر شده خالی است`"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "`Filtered words list has been cleaned`"
           else
				return "`لیست کلمات فیلتر شده پاک شد`"
           end
			end
			if ((matches[2] == 'rules' and not Clang) or (matches[2] == "قوانین" and Clang)) then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "`No rules available`"
             else
               return "`قوانین برای گروه ثبت نشده است`"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "`Group rules has been cleaned`"
          else
            return "`قوانین گروه پاک شد`"
			end
       end
			if ((matches[2] == 'welcome' and not Clang) or (matches[2] == "خوشامد" and Clang)) then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "`Welcome Message not set`"
             else
               return "`پیام خوشآمد گویی ثبت نشده است`"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "`Welcome message has been cleaned`"
          else
            return "`پیام خوشآمد گویی پاک شد`"
			end
       end
			if ((matches[2] == 'about' and not Clang) or (matches[2] == "درباره" and Clang)) then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "`No description available`"
            else
              return "`پیامی مبنی بر درباره گروه ثبت نشده است`"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdbot.changeChannelDescription(chat, "", dl_cb, nil)
             end
             if not lang then
				return "`Group description has been cleaned`"
           else
              return "`پیام مبنی بر درباره گروه پاک شد`"
             end
		   	end
        end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "پاکسازی" and Clang)) and is_admin(msg) then
			if ((matches[2] == 'owners' and not Clang) or (matches[2] == "صاحب" and Clang)) then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "`No owners in this group`"
            else
                return "`مالکی برای گروه انتخاب نشده است`"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "`All owners has been demoted`"
           else
            return "`تمامی مالکان گروه تنزیل مقام شدند`"
          end
			end
     end
if ((matches[1] == "setname" and not Clang) or (matches[1] == "تنظیم نام" and Clang)) and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdbot.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if ((matches[1] == "setabout" and not Clang) or (matches[1] == "تنظیم درباره" and Clang)) and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdbot.changeChannelDescription(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "`Group description has been set`"
    else
     return "`پیام مبنی بر درباره گروه ثبت شد`"
      end
  end
  if ((matches[1] == "about" and not Clang) or (matches[1] == "درباره" and Clang)) and msg.to.type == "chat" and is_owner(msg) then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "`No description available`"
      elseif lang then
      about = "`پیامی مبنی بر درباره گروه ثبت نشده است`"
       end
        else
     about = "`Group Description :`\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if ((matches[1] == 'filter' and not Clang) or (matches[1] == "فیلتر" and Clang)) and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if ((matches[1] == 'unfilter' and not Clang) or (matches[1] == "حذف فیلتر" and Clang)) and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if ((matches[1] == 'filterlist' and not Clang) or (matches[1] == "لیست فیلتر" and Clang)) and is_mod(msg) then
    return filter_list(msg)
  end
if ((matches[1] == "settings1" and not Clang) or (matches[1] == "تنظیمات1" and Clang)) and is_mod(msg) then
return group_settings(msg, target)
end
if ((matches[1] == "settings2" and not Clang) or (matches[1] == "تنظیمات2" and Clang)) and is_mod(msg) then
return mutes(msg, target)
end
if ((matches[1] == "modlist" and not Clang) or (matches[1] == "لیست مدیران" and Clang)) and is_mod(msg) then
return modlist(msg)
end
if ((matches[1] == "ownerlist" and not Clang) or (matches[1] == "لیست صاحب" and Clang)) and is_owner(msg) then
return ownerlist(msg)
end
if ((matches[1] == "viplist" and not Clang) or (matches[1] == "لیست ویژه" and Clang)) and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if ((matches[1]:lower() == "panel" and not Clang) or (matches[1] == "پنل" and Clang)) and is_mod(msg) then
local function found_helper(TM, Beyond)
local function inline_query_cb(TM, BD)
      if BD.results and BD.results[0] then
		redis:setex("ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true)	tdbot.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, BD.inline_query_id, BD.results[0].id, dl_cb, nil)
    else
    if not lang then
    text = "`Helper is offline`\n\n"
        elseif lang then
    text = "`ربات هلپر خاموش است`\n\n"
    end
  return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdbot.getInlineQueryResults(Beyond.id, msg.to.id, nil, nil, msg.to.id, 0, inline_query_cb, nil)
end
tdbot.searchPublicChat(tostring(helper_username), found_helper, nil)
end

if (matches[1]:lower() == "setlang" and not Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "fa" then
redis:set(hash, true)
return "`زبان گروه تنظیم شد به :` 《`فارسی`》"..msg_caption
  elseif matches[2] == "en" then
 redis:del(hash)
return "`Group Language Set To:` 《`EN`》"..msg_caption
end
end
if (matches[1] == 'زبان' and Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "فارسی" then
redis:set(hash, true)
return "`زبان گروه تنظیم شد به :` 《`فارسی`》"..msg_caption
  elseif matches[2] == "انگلیسی" then
 redis:del(hash)
return "`Group Language Set To:` 《`EN`》"..msg_caption
end
end

if (matches[1]:lower() == "setcmd" and not Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
if matches[2] == "fa" then
redis:set(hash, true)
   if lang then
return "`زبان دستورات ربات تنظیم شد به :` 《`فارسی`》"..msg_caption
else
return "`Bot Commands Language Set To:` 《`Fa`》"..msg_caption
end
end
end

if (matches[1]:lower() == "دستورات انگلیسی" and Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
redis:del(hash)
   if lang then
return "`زبان دستورات ربات تنظیم شد به :` 《`انگلیسی`》"..msg_caption
else
return "`Bot Commands Language Set To:` 《`EN`》"..msg_caption
end
end

--------------------- Welcome -----------------------
	if ((matches[1] == "welcome" and not Clang) or (matches[1] == "خوشامد" and Clang)) and is_mod(msg) then
		if ((matches[2] == "+" and not Clang) or (matches[2] == "+" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "┃✓┃" then
       if not lang then
				return "`Group welcome is already enabled`"
       elseif lang then
				return "`خوشآمد گویی از قبل فعال بود`"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "┃✓┃"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "`Group welcome has been enabled`"
       elseif lang then
				return "`خوشآمد گویی فعال شد`"
          end
			end
		end
		
		if ((matches[2] == "-" and not Clang) or (matches[2] == "-" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "┃✘┃" then
      if not lang then
				return "`Group Welcome is already disabled`"
      elseif lang then
				return "`خوشآمد گویی از قبل فعال نبود`"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "┃✘┃"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "`Group welcome has been disabled`"
      elseif lang then
				return "`خوشآمد گویی غیرفعال شد`"
          end
			end
		end
	end
	if ((matches[1] == "setwelcome" and not Clang) or (matches[1] == "تنظیم خوشامد" and Clang)) and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "`Welcome Message Has Been Set To :`\n*"..matches[2].."*\n\n`You can use :`\n`{gpname} Group Name`\n`{rules} ➣ Show Group Rules`\n`{time} ➣ Show time english `\n`{date} ➣ Show date english `\n`{timefa} ➣ Show time persian `\n`{datefa} ➣ show date persian `\n`{name} ➣ New Member First Name`\n`{username} ➣ New Member Username`"..msg_caption
       else
		return "`پیام خوشآمد گویی تنظیم شد به :`\n*"..matches[2].."*\n\n`شما میتوانید از`\n`{gpname} نام گروه`\n`{rules} ➣ نمایش قوانین گروه`\n`{time} ➣ ساعت به زبان انگلیسی `\n`{date} ➣ تاریخ به زبان انگلیسی `\n`{timefa} ➣ ساعت به زبان فارسی `\n`{datefa} ➣ تاریخ به زبان فارسی `\n`{name} ➣ نام کاربر جدید`\n`{username} ➣ نام کاربری کاربر جدید`\n`استفاده کنید`"..msg_caption
        end
     end
	-- end
end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdbot.getChannelMembers(msg.to.id, 0, 200, 'Administrators', function(a, b)
	local secchk = true
		for k,v in pairs(b.members) do
			if v.user_id == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdbot.sendMessage(msg.to.id, 0, 1, '', 1, "md")
			else
				return tdbot.sendMessage(msg.to.id, 0, 1, '', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://api.beyond-dev.ir/time/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "`Welcome Dude`"
    elseif lang then
     welcome = "`خوش آمدید`"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "`ℹ️ The Default Rules :`\n`1⃣ No Flood.`\n`2⃣ No Spam.`\n`3⃣ No Advertising.`\n`4⃣ Try to stay on topic.`\n`5⃣ Forbidden any racist, sexual, homophobic or gore content.`\n`➡️ Repeated failure to comply with these rules will cause ban`"
    elseif lang then
       rules = "`ℹ️ قوانین پپیشفرض:`\n`1⃣ ارسال پیام مکرر ممنوع.`\n`2⃣ اسپم ممنوع.`\n`3⃣ تبلیغ ممنوع.`\n`4⃣ سعی کنید از موضوع خارج نشید.`\n`5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .`\n`➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.`"
 end
end
if data.username then
user_name = "@"..check_markdown(data.username)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name..' '..(data.last_name or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdbot.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "┃✓┃" then
			tdbot.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "┃✓┃" then
			tdbot.getUser(msg.sender_user_id, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
 
return {
patterns ={
"^[!/#](id)$",
"^(id)$",
"^[!/#](id) (.*)$",
"^(id) (.*)$",
"^[!/#](pin)$",
"^(pin)$",
"^[!/#](unpin)$",
"^(unpin)$",
"^[!/#](gpinfo)$",
"^(gpinfo)$",
"^[!/#](test)$",
"^(test)$",
"^[!/#](install)$",
"^(install)$",
"^[!/#](uninstall)$",
"^(uninstall)$",
"^[!/#](panel)$",
"^(panel)$",
"^[!/#](vip) ([+-])$",
"^(vip) ([+-])$",
"^[!/#](vip) ([+-]) (.*)$",
"^(vip) ([+-]) (.*)$",
"^[#!/](viplist)$",
"^(viplist)$",
"^[!/#](setowner)$",
"^(setowner)$",
"^[!/#](setowner) (.*)$",
"^(setowner) (.*)$",
"^[!/#](remowner)$",
"^(remowner)$",
"^[!/#](remowner) (.*)$",
"^(remowner) (.*)$",
"^[!/#](promote)$",
"^(promote)$",
"^[!/#](promote) (.*)$",
"^(promote) (.*)$",
"^[!/#](demote)$",
"^(demote)$",
"^[!/#](demote) (.*)$",
"^(demote) (.*)$",
"^[!/#](modlist)$",
"^(modlist)$",
"^[!/#](ownerlist)$",
"^(ownerlist)$",
"^[!/#](lock) (.*)$",
"^(lock) (.*)$",
"^[!/#](unlock) (.*)$",
"^(unlock) (.*)$",
"^[!/#](settings1)$",
"^(settings1)$",
"^[!/#](settings2)$",
"^(settings2)$",
"^[!/#](mute) (.*)$",
"^(mute) (.*)$",
"^[!/#](unmute) (.*)$",
"^(unmute) (.*)$",
"^[!/#](link)$",
"^(link)$",
"^[!/#](linkpv)$",
"^(linkpv)$",
"^[!/#](setlink)$",
"^(setlink)$",
"^[!/#](newlink)$",
"^(newlink)$",
"^[!/#](rules)$",
"^(rules)$",
"^[!/#](setrules) (.*)$",
"^(setrules) (.*)$",
"^[!/#](about)$",
"^(about)$",
"^[!/#](setabout) (.*)$",
"^(setabout) (.*)$",
"^[!/#](setname) (.*)$",
"^(setname) (.*)$",
"^[!/#](clean) (.*)$",
"^(clean) (.*)$",
"^[!/#](setflood) (%d+)$",
"^(setflood) (%d+)$",
"^[!/#](setchar) (%d+)$",
"^(setchar) (%d+)$",
"^[!/#](setfloodtime) (%d+)$",
"^(setfloodtime) (%d+)$",
"^[!/#](res) (.*)$",
"^(res) (.*)$",
"^[!/#](whois) (%d+)$",
"^(whois) (%d+)$",
"^[!/#](setlang) (.*)$",
"^(setlang) (.*)$",
"^[!/#](setcmd) (.*)$",
"^(setcmd) (.*)$",
"^[#!/](filter) (.*)$",
"^(filter) (.*)$",
"^[#!/](unfilter) (.*)$",
"^(unfilter) (.*)$",
"^[#!/](filterlist)$",
"^(filterlist)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#](setwelcome) (.*)",
"^(setwelcome) (.*)",
"^[!/#](welcome) (.*)$",
"^(welcome) (.*)$",
"^(زبان) (.*)$",
"^(دستورات انگلیسی)$",
"^(ایدی)$",
"^(ایدی) (.*)$",
"^(آیدی)$",
"^(آیدی) (.*)$",
'^(تنظیمات1)$',
'^(پنل)$',
'^(سنجاق)$',
'^(حذف سنجاق)$',
'^(نصب)$',
'^(لغو نصب)$',
'^(ادمین گروه)$',
'^(ادمین گروه) (.*)$',
'^(حذف ادمین گروه) (.*)$',
'^(حذف ادمین گروه)$',
'^(ویژه) ([+-]) (.*)$',
'^(ویژه) ([+-])$',
'^(لیست ویژه)$',
'^(صاحب)$',
'^(صاحب) (.*)$',
'^(حذف صاحب) (.*)$',
'^(حذف صاحب)$',
'^(ترفیع)$',
'^(ترفیع) (.*)$',
'^(تنزل)$',
'^(تنزل) (.*)$',
'^(قفل) (.*)$',
'^(بازکردن) (.*)$',
'^(بیصدا) (.*)$',
'^(باصدا) (.*)$',
'^(لینک جدید)$',
'^(لینک جدید) (خصوصی)$',
'^(اطلاعات گروه)$',
'^(دستورات) (.*)$',
'^(قوانین)$',
'^(لینک)$',
'^(تنظیم لینک)$',
'^(تنظیم قوانین) (.*)$',
'^(لینک خصوصی)$',
'^(کاربری) (.*)$',
'^(شناسه) (%d+)$',
'^(تنظیم پیام مکرر) (%d+)$',
'^(تنظیم زمان بررسی) (%d+)$',
'^(حداکثر حروف مجاز) (%d+)$',
'^(پاکسازی) (.*)$',
'^(درباره)$',
'^(تنظیم نام) (.*)$',
'^(تنظیم درباره) (.*)$',
'^(لیست فیلتر)$',
'^(تنظیمات2)$',
'^(لیست صاحب)$',
'^(لیست مدیران)$',
'^(فیلتر) (.*)$',
'^(حذف فیلتر) (.*)$',
'^(خوشامد) (.*)$',
'^(تنظیم خوشامد) (.*)$',


},
run=run,
pre_process = pre_process
}
--end groupmanager.lua #beyond team#
