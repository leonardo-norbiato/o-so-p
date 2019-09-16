#!/bin/sh
#|-----------------------------------------------------|
#| INICIO Função cEcho - colored echo
#|-----------------------------------------------------|
cecho() {
  local code="\033["
  case "$1" in
    black  | bk) color="${code}0;30m";;
    red    |  r) color="${code}1;31m";;
    green  |  g) color="${code}1;32m";;
    yellow |  y) color="${code}1;33m";;
    blue   |  b) color="${code}1;34m";;
    purple |  p) color="${code}1;35m";;
    cyan   |  c) color="${code}1;36m";;
    gray   | gr) color="${code}0;37m";;
    *) local text="$1"
  esac
  [ -z "$text" ] && local text="$color$2${code}0m"
  printf "$text\n"
}
#|-----------------------------------------------------|
#| FIM Função cEcho - colored echo
#|-----------------------------------------------------|
cecho r "removendo rede para database"
docker network rm netdb
cecho r "rede removida"
sleep 5
cecho g "Criando rede para database"
docker network create --scope=swarm --driver=bridge --subnet=172.22.0.0/16 --gateway=172.22.0.1 netdb
sleep 5
cecho g "Rede criada"