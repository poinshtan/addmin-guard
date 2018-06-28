function run(msg,matches)
if (matches[1]:lower() == 'clean msgs' or matches[1] == 'پاکسازی پیام ها') and is_owner(msg)  then
local function pro(arg,data)
for k,v in pairs(data.members) do
tdbot.deleteMessagesFromUser(msg.chat_id, v.user_id, dl_cb, nil) 
end
end
local function cb(arg,data)
for k,v in pairs(data.messages) do
del_msg(msg.chat_id, v.id)
end
end
for i = 1, 5 do
tdbot.getChatHistory(msg.to.id, msg.id, 0,  500000000, 0, cb, nil)
end
for i = 1, 2 do
tdbot.getChannelMembers(msg.to.id, 0, 50000, "Search", pro, nil)
end
for i = 1, 1 do
tdbot.getChannelMembers(msg.to.id, 0, 50000, "Recent", pro, nil)
end
for i = 1, 5 do
tdbot.getChannelMembers(msg.to.id, 0, 50000, "Banned", pro, nil)
end
return "✬ *درحال پاکسازی پیام های گروه*"
end
------------------------------
if (matches[1]:lower() == 'mydel' ) or (matches[1] == 'پاکسازی پیام های من' ) then  
tdbot.deleteMessagesFromUser(msg.to.id,  msg.sender_user_id, dl_cb, nil) 
return "✬ *پیام های کاربر :*\n[@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]\n *پاکسازی شد توسط خودش*"
end
------------------------------
if ((matches[1]:lower() == "del" ) or (matches[1] == "حذف" ))  and tonumber(msg.reply_to_message_id) ~= 0 and is_mod(msg) then
tdbot.deleteMessages(msg.to.id, {[0] = tonumber(msg.reply_id)}, true, dl_cb, nil)
end
------------------------------
if (matches[1]:lower() == 'rmsg' ) or (matches[1] == 'پاکسازی' ) then
if tonumber(matches[2]) > 100 then
tdbot.sendMessage(msg.chat_id,  msg.id, 0, "✬ *عددی بین * [`1-100`] را انتخاب کنید", 0, "md")
else
local function cb(arg,data)
for k,v in pairs(data.messages) do
del_msg(msg.chat_id, v.id)
end
end
tdbot.getChatHistory(msg.to.id, msg.id, 0,  matches[2], 0, cb, nil)
tdbot.sendMessage(msg.chat_id,  msg.id, 0, "✬ تعداد ("..matches[2]..") پیام پاکسازی شد", 0, "md")
end
end
------------------------------
end

return {
	patterns = {
	"^[!/#](clean msgs)$",
	"^([Cc]lean msgs)$",
	"^[!/#](mydel)$",
	"^([Mm]ydel)$",
	"^[!/#](del)$",
	"^([Dd]el)$",
	"^[!/#](rmsg) (%d+)$",
	"^([Rr]msg) (%d+)$",
	"^(پاکسازی پیام ها)$",
	"^(پاکسازی پیام های من)$",
	"^(حذف)$",
	"^(پاکسازی) (%d+)$",
	},
	run = run
}

