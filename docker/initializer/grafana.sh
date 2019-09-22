#!/bin/bash
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
resposta="n"
cecho y "\nDeseja remover o volume do grafana? Isso excluirá todos os dados salvos. (y/n)"
read -p "...aguardando (5 seg): " -t 5 resposta
if [[ "$resposta" == "y" || "$resposta" == "Y" || "$resposta" == "yes" || "$resposta" == "Yes" || "$resposta" == "Sim" || "$resposta" == "sim" || "$resposta" == "s" || "$resposta" == "S" ]]; then
  sleep 3
  ./etc/grafana-volume.sh
fi
cecho r "\n Removendo container Grafana"
docker stack rm grafana
sleep 5
cecho r "grafana removido"
sleep 5
cecho g "Instalando grafana"
docker stack deploy --compose-file=grafana.yml grafana
cecho g "grafana instaladas"
sleep 3