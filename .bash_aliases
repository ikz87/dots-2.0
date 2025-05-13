alias ls='lsd'
alias lsa='lsd -a'
#alias clear='rst'
#alias vim='nvim'
alias icat="kitty +kitten icat"
alias pqiv='pqiv -i -c'
alias bc="BC_ENV_ARGS=<(echo "scale=4") \bc"
alias nanaclap="chafa ~/Pictures/General/nanaclap.gif"
alias nanaspin="pqiv -t -i -c -T 'nanaspinwin' ~/Pictures/General/nanaclap.gif"
alias nanacross="pqiv -t -i -c -T 'nanacrosswin' ~/Pictures/General/nanaclap.gif"
alias nanacube="pqiv -t -i -c -T 'nanacubewin' ~/Pictures/General/nanaclap.gif"
alias tt="tt -t 15 -showwpm" 
alias gping="ping google.com"
alias resetwal="hsetroot -cover ~/.config/rice_assets/Images/wallpaper.png"
alias updatedots='currdir="$(pwd)" && cd ~/Code/dots-2.0 && git commit -a && git push; cd "$currdir"'
alias sedit='sudoedit'
alias cl='clear'
alias rpp='sudo screen /dev/ttyACM1 9600'
#alias pgweb='pgweb --url $POSTGRES_CONNECTION_STRING'
alias ssh='TERM=xterm && ssh'

#alias startx='startx ~/.xinitrc'
alias prisma="python -m prisma"
