نصب سورس ورژن 4.0 بگا پلاس برپایه TeleGramBot
➖➖➖➖➖➖➖➖➖
نصب ربات Cli بگا پلاس

〰〰〰〰〰〰〰〰〰
وارد به مسیر [ bot/bot.lua ] بروید در لاین [23] یوزرنیم ربات هلپر و در لاین [133] ایدی سودو + ایدی ربات Api و Cli قرار دهید | به مسیر [ plugins/SPlus.lua ] بروید و در لاین  [3] ایدی سودو اصلی را قرار دهید
〰〰〰〰〰〰〰〰〰

cd addmin-guard && cd MeGaPlus && chmod +x megaplus.sh && ./megaplus.sh install

./megaplus.sh config

./megaplus.sh logcli

screen ./autotdbot.sh
➖➖➖➖➖➖➖➖➖
نصب ربات Helper مگا پلاس

〰〰〰〰〰〰〰〰〰
وارد به مسیر [ Helper/bot/bot.lua ] بروید در لاین [4] توکن ربات هلپر و در لاین [5] ایدی سودو  و در لاین [168] ایدی سودو + ایدی ربات Cli و Api قرار دهید
〰〰〰〰〰〰〰〰〰

cd addmin-guard && cd MeGaPlus/Helper && chmod +x megaplus.sh && ./megaplus.sh install && screen ./megaplus.sh
➖➖➖➖➖➖➖➖➖
قبل از اتولانچ دستور زیر بزنید

killall screen && killall bash && killalll tmux
➖➖➖➖➖➖➖➖➖

اتولانچ ربات Cli

cd addmin-guard && cd MeGaPlus && screen ./autotdbot.sh
➖➖➖➖➖➖➖➖➖
اتولانچ ربات Api

cd addmin-guard && cd MeGaPlus/Helper && screen ./megaplus.sh
