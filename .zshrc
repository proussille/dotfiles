#############
# Oh-my-zsh #
#############

# Path to your oh-my-zsh configuration.
ZSH=$HOME/oh-my-zsh

# Theme
ZSH_THEME="miloshadzic"

# Plugins
plugins=(git autojump git-flow github symfony2)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/erwan_f16/.local/bin:/home/erwan_f16/bin

#########
# Alias #
#########

# Gestion du 'ls' : couleur & ne touche pas aux accents
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

# Demande confirmation avant d'écraser un fichier
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive'

# Raccourcis pour 'ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# Quelques alias pratiques
alias c='clear'
alias less='less --quiet'
alias s='cd ..'
alias df='df --human-readable'
alias du='du --human-readable'
alias md='mkdir'
alias rd='rmdir'

########################################
# Options de zsh (cf 'man zshoptions') #
########################################

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
unsetopt clobber

# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof

# Affiche le code de sortie si différent de '0'
# setopt print_exit_value

# Demande confirmation pour 'rm *'
unsetopt rm_star_silent

# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
#setopt correct
# Si on utilise des jokers dans une liste d'arguments, retire les jokers
# qui ne correspondent à rien au lieu de donner une erreur
setopt nullglob

# Schémas de complétion

# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
unsetopt list_ambiguous

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effacé
setopt auto_remove_slash

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify

# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd

# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd

# Ignore les doublons dans la pile
setopt pushd_ignore_dups

# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent

# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice

# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup
