#!/bin/sh

# Baseado no script gen_debug 
# originalmente escrito por black.dragon74 

function show_kernel_log(){
        bt=$(sysctl -n kern.boottime | sed 's/^.*} //')

        bTm=$(echo "$bt" | awk '{print $2}')
        bTd=$(echo "$bt" | awk '{print $3}')
        bTt=$(echo "$bt" | awk '{print $4}')
        bTy=$(echo "$bt" | awk '{print $5}')

        bTm=$(awk -v "month=$bTm" 'BEGIN {months = "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"; print (index(months, month) + 3) / 4}')
        bTm=$(printf %02d $bTm)

        ep=$(/bin/date -jf '%H:%M:%S' $bTt '+%s')

        cs=$((ep - 60 ))

        bTt=$(/bin/date -r $cs '+%H:%M:%S')

        stopTime=$(log show --debug --info --start "$bTy-$bTm-$bTd $bTt" | grep loginwindow | head -1)
        stopTime="${stopTime%      *}"

        echo "Extract boot log from $bTy-$bTm-$bTd $bTt"

        log show --debug --info --start "$bTy-$bTm-$bTd $bTt" | grep -E 'kernel:|loginwindow:' | sed -n -e "/kernel: PMAP: PCID enabled/,/$stopTime/ p"
}

show_kernel_log
