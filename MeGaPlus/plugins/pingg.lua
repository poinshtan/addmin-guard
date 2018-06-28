--
local function AssassinsTeaM (msg ,matches)
if matches[1]:lower () == 'mehdi' or matches[1] == 'مهدی' then
return [[ ✭ ✭ ✭ ✭ ✭ ✭

general manager :

full name : mehdi poinshtan

username : @poinshtan88

tell number : +989190812156

🚬M.p 

]]
end
if matches[1] == 'honey' or matches[1] == 'ربات من' and is_sudo(msg) then
return '`جونم فرشته`❤️'
end
if matches[1] == 'چطوری؟' and is_sudo(msg) then
return '`هروقت تو خوب باشی منم خوبم`❤️'
end
 if matches[1] == 'امروز بهم گل ندادی 😐' and is_sudo(msg) then
return '`ببخشید مدیر بفرمایین` 🌸💐🌷🌹🥀🌺😊❤️'
end
if matches[1] == 'خاموشه' or matches[1] == 'ربات خاموشه' and is_sudo(msg) then
return 'نه قربان درخدمتم'
end
if matches[1] == 'خاموشه' or matches[1] == 'ربات خاموشه' then
return '😒هــی چ دارے  میـــــگے نمی بینــــی  روشنم'
end
if matches[1] == 'ping' or matches[1] == 'ربات' and is_sudo(msg) then
return " `درخدمتم مــدیــر`❤️ "
 end
if matches[1] == 'ping' or matches[1] == 'ربات' then
return 'نزن آنلاینم😐️'
end
if matches[1]:lower () == 'creator' or matches[1]:lower () == 'سازنده' then
return [[Educated and written by
@GirlSudo

@Del_PvBot
✭ ✭ ✭ ✭ ✭ ✭
نوشته شده توسط:
@GirlSudo

@Del_PvBot
]]
end
end
return {
patterns = {

     "^([Mm][Ee][Hh][Dd][Ii])$",
	 "^([Hh][Oo][Nn][Ee][Yy])",
	 "^([Pp][Ii][Nn][Gg])",
	 "^([Cc]reator)$",
"^(مهدی)$",
"^(سازنده)$",
"^(ربات)$",
"^(چطوری؟)$",
"^(خاموشه)$",
"^(ربات خاموشه)$",
"^(ربات من)$",
"^(امروز بهم گل ندادی 😐)$"
},
run =AssassinsTeaM,
}

