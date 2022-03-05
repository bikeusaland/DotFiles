export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PATH=/opt/homebrew/bin:$PATH
fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )
autoload -Uz compinit
compinit

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

alias gb="git branch -ra"
alias gp='git fetch --all; git pull'
alias gco="git checkout $1"
alias gl="git log --stat"
alias gup='for i in $(find ~/Desktop/Repos -name .git -type d -maxdepth 3 | cut -f1 -d.); do cd $i; echo $i; git branch; gp; done;'
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
jenkins_info="i-0f32ea33950583a8c --profile default --region us-east-1"
alias jenkins_reboot="aws ec2 reboot-instances --instance-ids $jenkins_info"
alias ssh_jenkins="aws ssm start-session --target $jenkins_info"
alias jenkins_restart_service="aws ssm send-command --document-name 'AWS-RunShellScript' --instance-ids i-0f32ea33950583a8c --profile default --region us-east-1 --comment 'Restaring Jenkins service' --parameters 'commands=[sudo systemctl restart jenkins]'"
alias aem_restart="aws ssm send-command --document-name 'AWS-RunShellScript' --targets "Key=tag:Environment,Values=Dev" --targets "Key=tag:Segment,Values=publisher" --profile default --region eu-west-1 --comment 'Restaring AEM service' --parameters 'commands=[sudo systemctl status aem65]'"

autoload -U promptinit; promptinit
# prompt spaceship

tf-log-debug () {
        [[ -z $1 ]] && LEVEL=TRACE
        export TF_LOG=$LEVEL
        export TF_LOG_PATH=/tmp/tf_debug.log
        echo -e "\033[32;1m[INFO]\033[0m Terraform log level set to debug.  Log output at $TF_LOG_PATH"
}

source ~/.awsrc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

aws_region_us1
