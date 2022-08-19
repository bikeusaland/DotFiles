export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PATH=/opt/homebrew/bin:$PATH
fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )
autoload -Uz compinit
compinit

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

#alias help='@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}''
#alias gb="git --no-pager branch -ra --sort=committerdate"
alias gb="git --no-pager branch -ra --sort=committerdate --format='%(refname) %09 %(committerdate:short) %09 %(authorname)'"
alias gp='git fetch --all; git pull'
alias gco="git checkout $1"
alias gl="git log --stat"
alias gup='for i in $(find ~/Desktop/Repos -name .git -type d -maxdepth 3 | cut -f1 -d.); do cd $i; echo $i; git branch; gp; done; cd ~/Desktop/Repos;'
alias tf="terraform"
alias tg="terragrunt"
alias k="kubectl"
alias grep="grep --exclude-dir='.;..;.git;.svn;.terraform'"
alias vi="vim -O $1"
alias kns="kubens"
alias ktx="kubectx"
alias python="python3"
alias ssm="aws ssm start-session --target $1"

##  Jenkins box
jenkins_info="<server id> --profile default --region us-east-1"
alias jenkins_reboot="aws ec2 reboot-instances --instance-ids $jenkins_info"
alias ssh_jenkins="aws ssm start-session --target $jenkins_info"
alias jenkins_restart_service="aws ssm send-command --document-name 'AWS-RunShellScript' --instance-ids <server id> --profile default --region us-east-1 --comment 'Restaring Jenkins service' --parameters 'commands=[sudo systemctl restart jenkins]'"
alias aem_restart="aws ssm send-command --document-name 'AWS-RunShellScript' --targets "Key=tag:Environment,Values=Dev" --targets "Key=tag:Segment,Values=publisher" --profile default --region eu-west-1 --comment 'Restaring AEM service' --parameters 'commands=[sudo systemctl status aem65]'"

autoload -U promptinit; promptinit
# prompt spaceship

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_DEF=$'\e[0m'
COLOR_USR=$'\e[38;5;243m'
COLOR_DIR=$'\e[38;5;197m'
COLOR_GIT=$'\e[38;5;39m'
setopt PROMPT_SUBST
#export PROMPT="${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ "
#export PROMPT="${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ "
export PROMPT='%n@%m %1~ %# '

tf-log-debug () {
        [[ -z $1 ]] && LEVEL=TRACE
        export TF_LOG=$LEVEL
        export TF_LOG_PATH=/tmp/tf_debug.log
        echo -e "\033[32;1m[INFO]\033[0m Terraform log level set to debug.  Log output at $TF_LOG_PATH"
}

source ~/.awsrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

aws_region_us1

PATH="/Users/gland/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/gland/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/gland/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/gland/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/gland/perl5"; export PERL_MM_OPT;
