#!/bin/bash
#yc compute instances list --format yaml | grep -A1 "created_at" | grep "name" | sed 's/name: //g' | sed 's/^[ ]*//g' > hostsnames.txt
#yc compute instances list --format yaml | grep -A1 "one_to_one_nat" | grep "address" | sed 's/address: //g' | sed 's/^[ ]*//g' > hosts.txt
hostsnames=($(yc compute instances list --format yaml | grep -A1 "created_at" | grep "name" | sed 's/name: //g' | sed 's/^[ ]*//g'))
hosts=($(yc compute instances list --format yaml | grep -A1 "one_to_one_nat" | grep "address" | sed 's/address: //g' | sed 's/^[ ]*//g'))

if [ "$1" == "--list" ]; then
cat<<EOF
{
    "_meta": {
        "hostvars": {
            "${hostsnames}": {
                "ansible_host": "${hosts}"
            }
        }
    },
    "all": {
        "children": [
            "docker",
            "ungrouped"
        ]
    },
    "docker": {
        "hosts": [
            "${hostsnames}"
        ]
    }
}
EOF
elif [ "$1" == "--host" ]; then
  echo '{"_meta": {hostvars": {}}}'
else
  echo "{ }"
fi
