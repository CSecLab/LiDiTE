#!/bin/sh

if [ "${PASSWORD_DEFAULT}" != "" ]; then
 cat >> /etc/uci-defaults/10_chassis_defaultpasswd << EOF
#!/bin/sh
echo -e "${PASSWORD_DEFAULT}\n${PASSWORD_DEFAULT}" | passwd
exit 0
EOF

unset -v PASSWORD_DEFAULT

fi

#if [ "${DEFAULT_NETWORK}" != "" ]; then
# echo "${DEFAULT_NETWORK}" > /etc/uci-defaults/50_chassis_network
#fi

#if [ "${DEFAULT_FIREWALL}" != "" ]; then
# echo "${DEFAULT_FIREWALL}" > /etc/uci-defaults/60_chassis_firewall
#fi

exec /sbin/init "$@"