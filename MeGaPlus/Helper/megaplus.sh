#!/usr/bin/env bash

cd $HOME/Api

install() {
		sudo apt-get update
		sudo apt-get upgrade
sudo apt-get install lua5.1 luarocks lua-socket lua-sec redis-server curl 
sudo luarocks install oauth 
sudo luarocks install redis-lua 
sudo luarocks install lua-cjson 
sudo luarocks install ansicolors 
sudo luarocks install serpent 
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
    txtlogo[1]="     αđмłи gυαяđ™"
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

function addminguard() {
	echo -e "\e[0m"
	green "     thanks to   >>>>                    🔱∂єℓαяαм🔱                             "
                    
	white "     edit by   >>>>                     mehdi poinshtan                               "



	red   "     >>>>                       @DelGuardTm                                     "
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

if [ "$1" = "install" ]; then
	print_logo
	addminguard
	logo_play
	install
elif [ "$1" = "update" ]; then
	logo_play
	addminguard
	update
	exit 1
else
	print_logo
	addminguard
	logo_play
	green "Enjoy the new generation of robots :)"
	#sudo service redis-server restart
	lua ./bot/bot.lua
fi
