alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable --group-directories-first --time-style=+"%d.%m.%Y %H:%M" '
alias lsfp='ls | sed s#^#$(pwd)/#' # ls avec full PATH
alias ll='ls -l'
alias la='ll -a'
alias lsofnames="lsof | awk '!/^\$/ && /\// { print \$9 }' | sort -u" # noms des fichiers ouverts
alias grep='grep --color=tty -d skip'
alias s='cd ..'
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive'
alias df='df -h'  # Tailles lisibles par l'homme
alias free='free -m'  # voir la taille en MB
alias servethis="php -S localhost:8000" # Serveur python sur le port 8000
if type -P htop >/dev/null; then
  alias top='htop' # toujours utiliser htop si installé
fi
alias reload_bash="source ~/.bashrc" # recharger le ~/.bashrc
alias psp='ps u -C' # ps sur un seul process
if type -P vim >/dev/null; then
  alias vi=vim # toujours utiliser vim au lieu de vi si installe
fi

alias c='clear'
bind '"\C-l"':"\"clear\r\"" # Ctrl+l vide le terminal

# Symfony aliases
alias sf="php app/console"

# Yum alias
alias yup="sudo yum update -y"

# Sublime Text alias
alias sub="/opt/sublime_text_3/sublime_text 2>/dev/null"
alias san="/opt/sublime_text_3/sublime_text -an . 2>/dev/null "

# Git alias
alias g="git status"

# Special alias
alias dropwatch="echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches"


#############
# Functions #
#############

myip(){ wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//';}

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjvf $1   ;;
      *.tar.gz)    tar xzvf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xvf $1    ;;
      *.tbz2)      tar xjvf $1   ;;
      *.tgz)       tar xzvf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo -e "${bldred}'$1' ne peut pas etre decompresse avec ex()" ;;
    esac
  else
    echo -e "\n${bldred}'$1' n'est pas un fichier valide"
  fi
}

clock() { while true;do clear;echo -e "\e[30;1m===========\e[0m\e[01;33m";date +"%r";echo -e "\e[0m\e[30;1m===========\e[0m";sleep 1;done; }

resetperm()
{
  chmod -R u=rwX,go=rX "$@"
  chown -R ${USER}:users "$@"
}

changeEncoding()
{
  if [ -f "$1" ] ; then
    case "`file -bi "$1"`" in
      *iso-8859-1)   iconv --from-code=ISO-8859-1 --to-code=UTF-8 "$1" > "$1".utf-8 && echo -e "\n${bldgrn}Nouveau fichier : "$1".utf-8"  ;;
      *utf-8)   iconv --from-code=UTF-8 --to-code=ISO-8859-1 "$1" > "$1".iso-8859-1 && echo -e "\n${bldgrn}Nouveau fichier : "$1".iso-8859-1" ;;
      *us-ascii)   echo -e "\n${bldylw}Encodage US-ASCII pas besoin de convertir"   ;;
      *)           echo -e "\n${bldred}L'encodage de '$1' ne peut pas etre converti avec changeEncoding(`file -bi "$1"`)" ;;
    esac
  else
    echo -e "\n${bldred}'$1' n'est pas un fichier valide"
  fi
}

cbt() { find ${*-.} -type f -print0 | xargs -0 file | awk -F, '{print $1}' | awk '{$1=NULL;print $0}' | sort | uniq -c | sort -nr ;}

# start, stop, restart, reload - Controler les services
# usage: start nom_du_daemon
start() { for arg in $*; do sudo service $arg start; done }
stop() { for arg in $*; do sudo service $arg stop; done }
restart() { for arg in $*; do sudo service $arg restart; done }
reload() { for arg in $*; do sudo service $arg reload; done }

function bashtips {
echo -e "
${txtpur}REPERTOIRES
----------------------------------------------------------------------${txtrst}
${txtcyn}~-          ${txtrst}repertoire precedent
${txtcyn}pushd tmp   ${txtrst}Push tmp && cd tmp
${txtcyn}popd        ${txtrst}Pop && cd
${txtcyn}save foo    ${txtrst}bookmark le dossier courant dans foo
${txtcyn}show        ${txtrst}voir une liste des bookmarks

${txtpur}HISTORIQUE
----------------------------------------------------------------------${txtrst}
${txtcyn}!!        ${txtrst}Derniere commande
${txtcyn}!!:p      ${txtrst}Apercu sans execution de la derniere commande
${txtcyn}!?foo     ${txtrst}Derniere commande contenant \`foo'
${txtcyn}^foo^bar^ ${txtrst}Derniere commande contenant \`foo', mais substitue avec \`bar'
${txtcyn}!!:0      ${txtrst}Derniere commande mot
${txtcyn}!!:^      ${txtrst}1er argument de la derniere commande
${txtcyn}!\$        ${txtrst}Dernier argument de la derniere commande
${txtcyn}!!:*      ${txtrst}Tout les arguments de la derniere commande
${txtcyn}!!:x-y    ${txtrst}Arguments x a y de la derniere commande
${txtcyn}[Ctrl]-s  ${txtrst}Rechercher en avant dans l'historique
${txtcyn}[Ctrl]-r  ${txtrst}Rechercher en arriere dans l'historique

${txtpur}EDITION DE LIGNE
----------------------------------------------------------------------${txtrst}
${txtcyn}[Ctrl]-a     ${txtrst}aller au debut de la ligne
${txtcyn}[Ctrl]-e     ${txtrst}aller a la fin de la ligne
${txtcyn}[ Alt]-d     ${txtrst}efface jusqu'a la fin d'un mot
${txtcyn}[Ctrl]-w     ${txtrst}efface jusqu'au debut d'un mot
${txtcyn}[Ctrl]-k     ${txtrst}efface jusqu'a la fin de la ligne
${txtcyn}[Ctrl]-u     ${txtrst}efface jusqu'au debut de la ligne
${txtcyn}[Ctrl]-y     ${txtrst}coller le contenu du buffer
${txtcyn}[Ctrl]-r     ${txtrst}revert all modifications to current line
${txtcyn}[Ctrl]-]     ${txtrst}chercher en avant dans la ligne
${txtcyn}[ Alt]-
  ${txtcyn}[Ctrl]-]   ${txtrst}chercher en arriere dans la ligne
${txtcyn}[Ctrl]-t     ${txtrst}switch lettre
${txtcyn}[ Alt]-t     ${txtrst}switch mot
${txtcyn}[ Alt]-u     ${txtrst}mot en Majuscule
${txtcyn}[ Alt]-l     ${txtrst}Mot en Minuscule
${txtcyn}[ Alt]-c     ${txtrst}1ere lettre du mot en Majuscule

${txtpur}COMPLETION
----------------------------------------------------------------------${txtrst}
${txtcyn}[ Alt].      ${txtrst}faire defiler les arguments de la derniere commande
${txtcyn}[ Alt]-/     ${txtrst}completer le nom de fichier
${txtcyn}[ Alt]-~     ${txtrst}completer le nom d'utilisateur
${txtcyn}[ Alt]-@     ${txtrst}completer le nom d'host
${txtcyn}[ Alt]-\$     ${txtrst}completer le nom de variable
${txtcyn}[ Alt]-!     ${txtrst}completer le nom d'une commande
${txtcyn}[ Alt]-^     ${txtrst}completer l'historique"

}
