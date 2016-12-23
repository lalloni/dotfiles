#!/usr/bin/env zsh
# vim: filetype=zsh tabstop=4 expandtab

LC_ALL=C

zmodload zsh/mathfunc

cpu_color_lut=(
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour52"
    "brightwhite colour88"
    "brightwhite colour88"
    "brightwhite colour88"
    "brightwhite colour88"
    "brightwhite colour88"
    "brightwhite colour88"
    "brightwhite colour88"
    "brightwhite colour124"
    "brightwhite colour124"
    "brightwhite colour124"
    "brightwhite colour124"
    "brightwhite colour124"
    "brightwhite colour124"
    "brightwhite colour124"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour160"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour196"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour202"
    "brightwhite colour208"
    "black colour208"
    "black colour208"
    "black colour208"
    "black colour208"
    "black colour208"
    "black colour208"
    "black colour214"
    "black colour214"
    "black colour214"
    "black colour214"
    "black colour214"
    "black colour214"
    "black colour214"
    "black colour214"
    "black colour220"
    "black colour220"
    "black colour220"
    "black colour220"
    "black colour220"
    "black colour220"
    "black colour220"
    "black colour226"
    "black colour226"
    "black colour226"
    "black colour226"
    "black colour226"
    "black colour226"
    "black colour227"
    "black colour227"
    "black colour227"
    "black colour227"
    "black colour227"
    "black colour227"
    "black colour228"
    "black colour228"
    "black colour228"
    "black colour228"
    "black colour228"
    "black colour229"
    "black colour229"
    "black colour229"
    "black colour229"
    "black colour229"
    "black colour230"
    "black colour230"
    "black colour230"
    "black colour230"
    "black colour230"
    "black colour231"
    "black colour231"
    "black colour231"
)

load_color_lut=(
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour16"
    "brightwhite colour17"
    "brightwhite colour17"
    "brightwhite colour17"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour59"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour60"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour102"
    "brightwhite colour103"
    "brightwhite colour103"
    "brightwhite colour103"
    "brightwhite colour103"
    "brightwhite colour103"
    "brightwhite colour103"
    "brightwhite colour103"
    "black colour103"
    "black colour103"
    "black colour109"
    "black colour109"
    "black colour109"
    "black colour109"
    "black colour109"
    "black colour109"
    "black colour145"
    "black colour145"
    "black colour145"
    "black colour145"
    "black colour145"
    "black colour145"
    "black colour145"
    "black colour145"
    "black colour146"
    "black colour146"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour152"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour188"
    "black colour195"
    "black colour195"
    "black colour195"
    "black colour195"
    "black colour231"
    "black colour231"
    "black colour231"
    "black colour231"
    "black colour231"
    "black colour231"
    "black colour231"
    "black colour231"
)

mem_color_lut=(
    "brightwhite colour16"
    "brightwhite colour17"
    "brightwhite colour18"
    "brightwhite colour18"
    "brightwhite colour18"
    "brightwhite colour18"
    "brightwhite colour18"
    "brightwhite colour18"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour24"
    "brightwhite colour60"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour66"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour72"
    "brightwhite colour71"
    "brightwhite colour71"
    "brightwhite colour71"
    "brightwhite colour107"
    "brightwhite colour107"
    "black colour107"
    "black colour107"
    "black colour108"
    "black colour108"
    "black colour108"
    "black colour108"
    "black colour108"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour144"
    "black colour150"
    "black colour150"
    "black colour186"
    "black colour186"
    "black colour186"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour180"
    "black colour181"
    "black colour181"
    "black colour181"
    "black colour181"
    "black colour187"
    "black colour187"
    "black colour187"
    "black colour187"
    "black colour188"
    "black colour224"
    "black colour224"
    "black colour224"
    "black colour224"
    "black colour224"
    "black colour231"
    "black colour231"
    "black colour231"
    "black colour231"
)

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
    echo "$cpu_color_lut[int(1+$u)] 'cpu $(printf "%0.1f%%" $u)'"
}

################################################################################
# Load segment functions #######################################################

function load_segment() {
    l=(${$(</proc/loadavg)[(w)1,(w)3]})
    p=$(nproc)  # core count
    s=100       # color levels
    m=2.0       # load-per-core alert level
    a=$l[1]     # 1m load average
    c=$[1 + int((s * a) / (m * p))]
    echo "$load_color_lut[c<s ? c : s] 'load $l'"
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
    echo "$mem_color_lut[1+$usage] 'ram $usage%'"
}

################################################################################
# Main #########################################################################

#echo "$(mem_segment)$(cpu_segment)$(load_segment)"

join_right_segments ${(z)"$(mem_segment)"} ${(z)"$(cpu_segment)"} ${(z)"$(load_segment)"}
