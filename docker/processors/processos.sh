#!/bin/bash
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
  printf "$text \n"
}
# implementar loop pedindo S/N1
for var in $(ls *.yml); do
   resposta="n"
   stack=${var/.yml/''}
   cecho y "\nDeseja efetuar o deploy do stack ${stack}? (y/n)"
   read -p "...aguardando (5 seg): " -t 5 resposta
   if [[ "$resposta" == "y" || "$resposta" == "Y" || "$resposta" == "yes" || "$resposta" == "Yes" || "$resposta" == "Sim" || "$resposta" == "sim" || "$resposta" == "s" || "$resposta" == "S" ]]; then
       docker stack rm ${stack}
       docker stack deploy --compose-file ${var} ${stack}
   fi
done
cecho "\n "