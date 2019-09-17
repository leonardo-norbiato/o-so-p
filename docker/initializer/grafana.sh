#!/bin/sh
#|-----------------------------------------------------|
#| Função cEcho - colored echo
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
cecho r "Removendo Grafana"
docker stack rm grafana
sleep 5
cecho r "grafana removido"
sleep 3
./etc/grafana-volume.sh
cecho g "Instalando grafana"
docker stack deploy --compose-file=grafana.yml grafana
cecho g "grafana instaladas"
sleep 3