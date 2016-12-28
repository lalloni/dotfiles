#!/usr/bin/env zsh
# vim: filetype=zsh tabstop=4 expandtab

LC_ALL=C

zmodload zsh/mathfunc

# Receives a value from 0 to 100 and returns a pair of foregroung and background
# terminal colors to represent the value in tmux style.
function alert_colors() {
    l=$1
    r=$((rint(0.05 * l)))
    g=0
    b=$((rint(0.05 * (l<=25 ? 4*l : (l<=50 ? 4*(50-l) : 0)))))
    lum=$((0.2*(20*r) + 0.7*(20*g) + 0.1*(20*b)))
    fgc=$((lum>50 ? 232 : 255))
    bgc=$((int(16 + 36 * r + 6 * g + b)))
    print -n "colour$fgc colour$bgc"
}

# Receives an array with triplets of (fg bg content) for each segment.
# The content part must be quoted if it has spaces.
function join_right_segments() {
    res=""
    while [[ $# -ge 3 ]] {
        confg=$1
        conbg=$2
        con=$3
        if [[ $prev_conbg == $conbg ]] {
            sep=""
            sepfg=$confg
        } else {
            sep=""
            sepfg=$conbg
        }
        prev_conbg=$conbg
        res+="#[fg=$sepfg]${sep}#[fg=$confg,bg=$conbg] ${(Q)con} "
        shift 3
    }
    echo "$res"
}

################################################################################
# CPU utilization segment functions ############################################

function cpu_segment() {
    a=(${$(</proc/stat)[(w)2,(w)5]})
    sleep 2s
    b=(${$(</proc/stat)[(w)2,(w)5]})
    usr=$((b[1]-a[1]))
    nic=$((b[2]-a[2]))
    sys=$((b[3]-a[3]))
    idl=$((b[4]-a[4]))
    u=$((100.0 * (usr+nic+sys) / (usr+nic+sys+idl)))
    echo "$(alert_colors $u) 'cpu $(printf "%0.1f%%" $u)'"
}

################################################################################
# Load segment functions #######################################################

function load_segment() {
    l=(${$(</proc/loadavg)[(w)1,(w)3]})
    p=$(nproc)  # core count
    m=4.0       # load-per-core max level
    a=$l[1]     # 1m load average
    c=$((int(100.0 * a / (m * p))))
    echo "$(alert_colors $((c<100 ? c : 100))) 'load $l'"
}

################################################################################
# Memory segment functions #####################################################

function mem_segment() {
    m=(${(f)"$(</proc/meminfo)"})
    total=${${(z)${(M)m:#MemTotal:*}}[2]}
    free=${${(z)${(M)m:#MemFree:*}}[2]}
    buffers=${${(z)${(M)m:#Buffers:*}}[2]}
    cached=${${(z)${(M)m:#Cached:*}}[2]}
    used=$((total - free - buffers - cached))
    usage=$((int(100.0 * used/total)))
    echo "$(alert_colors $usage) 'ram $usage%'"
}

################################################################################
# Main #########################################################################

join_right_segments ${(z)"$(mem_segment)"} ${(z)"$(cpu_segment)"} ${(z)"$(load_segment)"}
