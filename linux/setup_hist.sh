#!/bin/bash

called=$_
[[ $called == $0 ]] && { echo "Usage . $0"; exit 1; }

[ $(whoami) != "root" ] && { echo Must be root; exit 1; }

HIST_LOG="/var/log/history.log"
NOGROUP=$(groups nobody | awk '{print $NF}')

function hist_file_crt()
{
        touch ${HIST_LOG}
        chown nobody:${NOGROUP} ${HIST_LOG}
        chmod 002 ${HIST_LOG}
        chattr +a ${HIST_LOG}
        echo Permission: $(ls -l ${HIST_LOG})
}

if uname -a | grep -q '\.el[67]\.'
then
        OS=rhel
        BASHRC="/etc/bashrc"
else
        OS=ubuntu
        BASHRC="/etc/bash.bashrc"
fi

[ ! -f ${BASHRC} ] && { echo "${BASHRC}: No such file"; exit 1; }

if grep -q "HISTORY_FILE=" ${BASHRC}
then
        echo "${BASHRC}: HISTORY_FILE alrady set."
        exit 1
fi

hist_file_crt

cat >> ${BASHRC} << 'EOF'

# Customized Setting

function log_hist()
{
        thisHistID=$(history 1|awk '{print $1}')
        lastCommand=$(history 1|awk '{$1="" ;print}')
        tz=$(date +"%z")
        user=`id -un`
        whoStr=(`who -u am i`)
        realUser=${whoStr[0]}
        logDay=${whoStr[2]}
        logTime=${whoStr[3]}
        ip=${whoStr[6]}

        if [ ${thisHistID}x != ${lastHistID}x ];then
                echo -E "${tz}" $user\($realUser\)@$ip[LOGIN:$logDay $logTime] $lastCommand
                lastHistID=$thisHistID
        fi
}

HISTSIZE=10000
HISTTIMEFORMAT="%Y/%m/%d %T - "; export HISTTIMEFORMAT
export HISTORY_FILE=/var/log/history.log
export PROMPT_COMMAND='log_hist >> $HISTORY_FILE'
EOF

source ${BASHRC}

echo "cat ${HISTORY_FILE} to verify"
