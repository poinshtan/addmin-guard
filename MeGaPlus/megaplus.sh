#!/bin/bash

THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

install() {
	    cd td
		sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
		sudo apt-get install g++-4.7 -y c++-4.7 -y
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install libreadline-dev -y libconfig-dev -y libconfig++-dev -y libssl-dev -y lua5.2 -y liblua5.2-dev -y lua-socket -y lua-sec -y lua-expat -y libevent-dev -y make unzip git redis-server autoconf g++ -y libjansson-dev -y libpython-dev -y expat libexpat1-dev -y
		sudo apt-get install screen -y
		sudo apt-get install tmux -y
		sudo apt-get install libstdc++6 -y
		sudo apt-get install lua-lgi -y
		sudo apt-get install libnotify-dev -y
		wget https://valtman.name/files/telegram-bot-180116-nightly-linux
		mv telegram-bot-180116-nightly-linux tdbot
		chmod +x tdbot
		cd ..
		chmod +x bot
		chmod +x td
		chmod +x autotdbot.sh
}
function print_logo() {
	green "ⓦⓔⓛⓒⓞⓜⓔ 

… тєαм ℓσα∂єя …
﴾ @delaram_queen ﴿

… dεvεlσρεг …
﴾ @kianfaar ﴿

… sϑρρσгτ …
﴾ @del_pvbot ﴿

… λπτιsρλm bστ …

... ғor rep υѕerѕ
@Guard_Del2Bot
@Guard_Del3Bot

... ѕocιαl вoт
@Del_SuorceBot
@Del_LRoBot"
	echo -e "\n\e[0m"
}

function logo_play() {
    declare -A txtlogo
    seconds="0.010"
    txtlogo[1]="αđмłи gυαяđ™"
    printf "\e[31m\t"
    for i in ${!txtlogo[@]}; do
        for x in `seq 0 ${#txtlogo[$i]}`; do
            printf "${txtlogo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
    printf "\n"
	echo -e "\e[0m"
}
red() {
  printf '\e[1;31m%s\n\e[0;39;49m' "$@"
}
green() {
  printf '\e[1;32m%s\n\e[0;39;49m' "$@"
}
white() {
  printf '\e[1;37m%s\n\e[0;39;49m' "$@"
}
update() {
	git pull
}
deltgbot() {
 rm -rf $HOME/.telegram-bot
}
 config() {
mkdir $HOME/.telegram-bot; cat <<EOF > $HOME/.telegram-bot/config
default_profile = "cli";
cli = {
lua_script = "$HOME/addmin-guard/MeGaPlus/bot/bot.lua";
};
EOF
printf "\nConfig αđмłи gυαяđ™ Has Been Saved.\n"
}
megaplus() {
./td/tdbot | grep -v "{"
}

megapluscli() {
./td/tdbot -p cli --login --phone=${1}
} 

megaplusapi() {
./td/tdbot -p cli --login --bot=${1}
}

case $1 in
config)
print_logo
printf "Please wait...\n"
config ${2}
exit ;;

logcli)
print_logo
echo "Please Insert Your Bot Phone Number..."
read phone_number
addminGcli ${phone_number}
echo 'Your Cli Bot Loged In Successfully.'
exit;;

logapi)
print_logo
echo "Please Insert Your Bot Token..."
read Bot_Token
addminGapi ${Bot_Token}
echo 'Your Api Bot Loged In Successfully.'
exit;;

install)
print_logo
logo_play
install
exit;;

tdbot)
printf "Enjoy the new generation of robots :)\n"
print_logo
logo_play
addminG
exit;;

reset)
print_logo
printf "Please wait for delete telegram-bot...\n"
deltgbot
sleep 1
echo '.telegram-bot Deleted Successfully.'
exit;;

esac

exit 0
 
