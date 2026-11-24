#!/bin/bash
pwd
ls -la
tree
find . -name "file2.txt"
stat .
du -sh .
df -h
mkdir -p ~/cyber_lab
cd ~/cyber_lab
touch file1.txt file2.txt
echo "Kali Linux Lab" > file1.txt
cat file1.txt
cp file1.txt file2.txt
mv file2.txt copy.txt
head -n 10 file1.txt
tail -n 5 file1.txt
nano file1.txt
vim file1.txt
diff file1.txt copy.txt
chmod 755 ~/cyber_lab
sudo apt update
whoami
id
uname -a
hostname
uptime
date
free -h
lscpu
ps
 top -b -n 1
ip addr
ifconfig
ping -c 4 127.0.0.1
curl -I https://example.com
wget -O /tmp/example.html https://example.com
nslookup example.com
host example.com
dig example.com
apt list --installed | head
sudo apt install -y tree htop zip unzip whois dnsutils netcat-openbsd
htop
who
env
alias ll='ls -la'
echo "$HOME"
man ls
ls --help
clear
echo $?
printf 'alpha\nbeta\nalpha\n' | sort | uniq -c
printf 'one,two,three\n' | cut -d, -f2
printf 'hello world\n' | grep hello
sed 's/world/Kali/' <<< 'hello world'
ps aux | head
jobs
sleep 30 &
jobs
fg %1
kill -l
mkdir -p archive_demo
 echo "sample" > archive_demo/sample.txt
tar -cvf archive_demo.tar archive_demo
tar -xvf archive_demo.tar -C /tmp
gzip -k archive_demo/sample.txt
gunzip -k archive_demo/sample.txt.gz
zip -r archive_demo.zip archive_demo
unzip -l archive_demo.zip
whoami
id
who
env | head
xargs -n1 <<< 'one two three' echo
watch -n 2 date
