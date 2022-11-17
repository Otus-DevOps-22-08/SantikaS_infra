#!/bin/bash
#yc compute instances list --format yaml | grep -A1 "created_at" | grep "name" | sed 's/name: //g' | sed 's/^[ ]*//g' > hostsnames.txt
#yc compute instances list --format yaml | grep -A1 "one_to_one_nat" | grep "address" | sed 's/address: //g' | sed 's/^[ ]*//g' > hosts.txt
hostsnames=($(yc compute instances list --format yaml | grep -A1 "created_at" | grep "name" | sed 's/name: //g' | sed 's/^[ ]*//g'))
hosts=($(yc compute instances list --format yaml | grep -A1 "one_to_one_nat" | grep "address" | sed 's/address: //g' | sed 's/^[ ]*//g'))
hostsin=($(yc compute instances list --format yaml | grep -A1 "primary_v4_address" | grep "address" | sed 's/address: //g' | sed 's/^[ ]*//g'))
echo "DATABASE_URL="${hostsin[3]} > db_config.j2
#sed -i '1s/^.*${hostsin[3]}' environments/stage/group_vars/app
if [ "$1" == "--list" ]; then
cat<<EOF
{
    "_meta": {
        "hostvars": {
            "${hostsnames[0]}": {
                "ansible_host": "${hosts[0]}"
            },
            "${hostsnames[1]}": {
                "ansible_host": "${hosts[1]}"
            }
        }
    },
    "all": {
        "children": [
            "app",
            "db",
            "ungrouped"
        ]
    },
    "app": {
        "hosts": [
            "${hostsnames[0]}"
        ]
    },
    "db": {
        "hosts": [
            "${hostsnames[1]}"
        ]
    }
}
EOF
elif [ "$1" == "--host" ]; then
  echo '{"_meta": {hostvars": {}}}'
else
  echo "{ }"
fi
#rm hosts.txt
#rm hostsnames.txt
