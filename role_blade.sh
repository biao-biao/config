#!/bin/bash

declare -A arr_role arr_pod

awk -F. '{print $1}' | sort | uniq | { while read blade
do
        role_name=$(echo $blade | cut -c 7-9)
        pod_number=$(echo $blade | cut -c 5-6)
        arr_role[$role_name$pod_number]=${arr_role[$role_name$pod_number]}$blade","
        arr_pod[$role_name$pod_number]=""
done

for role in ${!arr_role[@]}
do
        echo $role
        echo ${arr_role[$role]%?}
done

for pod in ${!arr_pod[@]}
do
        pod_list=${pod_list}${pod}","
done

echo
echo ${pod_list%?}
}
