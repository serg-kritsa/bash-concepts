#!/bin/bash
#This is a single comment

# tldp bash scripting guide # https://tldp.org/LDP/abs/html/

### add right to execution
# $ chmod u+x scriptname
# ./scriptname
### show shells
# $ cat /etc/shells
# $ which bash


d=$(pwd)
echo $d
#
a=$(ping -c 1 example.com | grep 'bytes from' | cut -d = -f 4)
echo "The ping was $a"
#
today=$(date +"%d-%m-%Y")
time=$(date +"%H:%M:%S")
printf -v d "Current User:\t%s\nDate:\t\t%s @ %s\n" $USER $today $time
echo d
#
d=2
e=$((d+2))
echo $e
((e++))
echo $e
((e--))
echo $e
((e+=5))
echo $e
((e*=3))
echo $e
((e/=3))
echo $e
((e-=4))
echo $e
# 
f=$((1/3))
echo $f # 0
g=$(echo 1/3 | bc -l)
echo $g
# 
echo FF | bc # 99
# ???????????
a=1; b=2
echo $(( a + b ))
echo $(( a - b ))
echo $(( a * b ))
echo $(( a / b ))
echo $(( a % b ))
echo $( expr $a + $b )
echo $( expr $a - $b )
echo $( expr $a * $b )
echo $( expr $a / $b )
echo $( expr $a % $b )

# # # ===============================================================
# # # comparison
# # # ===============================================================
# text
[[ $a < $b ]]
[[ $a <= $b ]]
[[ $a > $b ]]
[[ $a >= $b ]]
[[ $a == $b ]]
[[ $a != $b ]]
#
[[ "cat" == "cat" ]]; echo $? # 0
[[ "cat" == "dog" ]]; echo $? # 1
[[ 20 > 100 ]]; echo $? # 0 ## incorrect lexical comparison as text
[[ 2 > 100 ]]; echo $? # 0 ## incorrect lexical comparison as text
# ?????????????????? comparison by length
echo "enter 1st string"; read str1
echo "enter 2st string"; read str2
if [ "$str1" \< "$str2" ]; then echo "$str1 is smaller then $str2"
elif [ "$str1" \> "$str2" ]; then echo "$str2 is smaller then $str1"
else echo "both strings are equal" fi
# numbers
[[ $a -lt $b ]]
[[ $a -lte $b ]]
[[ $a -gt $b ]]
[[ $a -gte $b ]]
[[ $a -eq $b ]]
[[ $a -ne $b ]]
#
[[ 20 -gt 100 ]]; echo $? # 1 ## means false
[[ 20 -lt 100 ]]; echo $? # 0 ## means true
#
a=""; b="cat"
[[ -z $a && -n $b ]]; echo $? # 0
### concatenation
a="hello"; b="world"; c=$a$b # helloworld
echo $c ${#a} ${#b}
# ???????????????? capitalize && uppercase
echo "enter a string"; read str
echo ${str^} # capitalize
echo ${str^^} # to uppercase
# get part of string
d=${c:3} # loworld
e=${c:3:4} # lowo
### str length ## https://www.shellhacks.com/ru/bash-string-length/
link=$1; echo ${#link}
$ expr length Hello 
$ echo Hello | wc -c
$ echo Hello | awk '{ print length }'
$ awk '{ print length($0) }' file # every str in file

### replace in string
fruit="apple banana banana cherry"
echo ${fruit//banana/durian} # apple durian banana cherry
echo ${fruit/banana/durian} # apple durian durian cherry
echo ${fruit/#apple/durian} # durian banana banana cherry
echo ${fruit/%cherry/durian} # apple banana banana durian
echo ${fruit/b*/durian} # apple durian

# # # ===============================================================
# # # formatting output
# # # ===============================================================
# COLOR   FG  BG # colored text (ANSI)
# black   30  40
# red     31  41
# green   32  42
# yellow  33  43
# blue    34  44
# magenta 35  45
# cyan    36  46
# white   37  47
# \033 == \e
echo -e '\033[37;40mWhite on Black\033[0m' # 
echo -e '\033[34;42mBlack on Red\033[0m' # 
echo -e '\033[34;42mGreen on Black\033[0m' # 
echo -e '\033[34;42mRed on White\033[0m' # 
echo -e '\033[34;42mBlue on Yellow\033[0m' # 
# STYLE           VALUE # styled text (ANSI)
# no style        0
# bold            1
# low intensity   2
# underline       4
# blinking        5
# reverse         7
# invisible       8
flashred="\033[5;31;40m"
red="\033[31;40m"
none="\033[0m"
echo -e $flashred"ERROE: "$none$red"Something went wrong."$none
# STYLE           COMMAND # styled text (tput)
# foreground      tput setaf [0-7]
# background      tput setab [0-7]
# no style        tput svg0
# bold            tput bold
# low intensity   tput dim
# underline       tput smul
# blinking        tput blink
# reverse         tput rev
# COLOR   setaf  setab # colored text (tput)
# black   0      0
# red     1      1
# green   2      2
# yellow  3      3
# blue    4      4
# magenta 5      5
# cyan    6      6
# white   7      7
flashred=$(tput setab 0; tput setaf 1; tput blink)
red=$(tput setab 0; tput setaf 1)
none=$(tput svg0)
echo -e $flashred"ERROE: "$none$red"Something went wrong."$none
###
$ printf "Name:\t%s\t\nID:\t%04d\n" "User" "12"
today=$(date +"%d-%n-%Y")
time=$(date +"%H:%M:%S")
print -v d "Current User:\t%s\nDate:\t\t%s @ %s\n" $USER $today $time
echo "$d"
# # # ===============================================================
# # # Arrays
# # # ===============================================================
a=()
b=("apple" "banana" "cherry")
echo ${b[2]}
b[5]="kiwi"
b+=("mango")
echo ${!b[@]} # 0 1 2 3 # keys
echo ${b[@]} # apple banana cherry kiwi mango # values
echo ${#b[@]} # array length
echo ${b[@]: -1} # mango
# print array values
arr=("apple" "banana" "cherry")
for i in ${arr[@]}
do
    echo $i
done
# map
declare -A myarray
myarray[color]=blue
myarray["office building"]="HQ West"
echo ${myarray["office building"]} is ${myarray[color]} 
# print map 
declare -A arr
arr["name"]="John"
arr["id"]="123"
for i in "${!arr[@]}" # get map keys 
do
    echo "$i: ${arr[$i]}"
done
# # # ===============================================================
# # # files & dirs
# # # ===============================================================
$ echo "Some text" > file.txt
$ cat file.txt
$ > file.txt # clear file content 
$ cat file.txt # no output
$ echo "Some text" > file.txt
$ echo "Some more text" >> file.txt
$ cat file.txt
# reading file
i=1
while read f; do
    echo "Line $i: $f"
    ((i++))
done < file.txt
# ????????????? reading file
read -p "Enter filename from which you want to read" filename
if [[ -f "$filename" ]]; then
    while IFS= read -r line; do echo $line
    done < $filename
else echo "$filename doesn't exist"; fi
# ????????????? deleting file
read -p "Enter filename from which you want to delete" filename
if [[ -f "$filename" ]]; then 
    rm $filename
    if [$? == 0]; then echo file has been successfully deleted
else echo "$filename doesn't exist"; fi
#
cat < file.txt
# '-' after << means to remove tabs
cat <<- EndOfText
    multiline
    string
EndOfText
# ????????????????????? -d
echo "Enter dir name to check: "; read dir
if [ -d "$dir" ]; then echo "$dir exists"
else echo "$dir doesn't exist"; fi
# ????????????????????? -f
echo "Enter file name to check: "; read filename
if [[ -f "$filename" ]]; then echo "$filename exists"
else echo "$filename doesn't exist"; fi

# ?????????????????????
ls -al 1>file1.txt 2>file2.txt
ls +al 1>file1.txt 2>file2.txt
# ?????????????????????
ls -al > file.txt 2>&1
ls -al >& file.txt
###
freespace=$(df -h / | grep -E "\/$" | awk '{print $4}')
greentext="\033[32m"
bold="\033[1m"
normal="\033[0m"
logdate=$(date +"%Y%m%d")
logtime="$logdate"_report.log

echo -e $bold"Quick system report for "$greentext"$HOSTNME"$normal
printf "\tSystem type:\t%s\n" $MACHTYPE
printf "\tBash Version:\t%s\n" $BASH_VERSION
printf "\tFree Space:\t%s\n" $freespace
printf "\tFiles in dir:\t%s\n" $(ls | wc -l)
printf "\tGenerated on:\t%s\n" $(date +"%m%d%y")
echo -e $greentext"A summary of this info has been saved to $logfile"$normal

cat <<-EOF > $logfile
    This report
    contains a summary
EOF
printf "SYS:\t%s\n" $MACHTYPE >> $logfile
printf "BASH:\t%s\n" $BASH_VERSION >> $logfile

# # # ===============================================================
# # # if statement
# # # ===============================================================
a=5
if [ $a -gt 4 ]; then
    echo $a is greater than 4!
else
    echo $a is not greater than 4!
fi
# ??????????????????????
a=5
if (($a > 4)); then
    echo $a is greater than 4!
else
    echo $a is not greater than 4!
fi
# ??????????????????????
a=5
if (($a > 4)); then
    echo $a is greater than 4!
elif (($a == 4)); then
    echo $a is equal 4!
else
    echo $a is not greater than 4!
fi 
# ????????????????????
age=10
if [ "$age" -gt 18 ] && [ "$age" -lt 40 ]; then
    echo Age is correct
else
    echo Age is not correct
fi 
# ????????????????????
age=10
if [[ "$age" -gt 18 && "$age" -lt 40 ]]; then
    echo Age is correct
else
    echo Age is not correct
fi 
# ????????????????????
age=30
if [[ "$age" -gt 18 || "$age" -lt 40 ]]; then
    echo Age is correct
else
    echo Age is not correct
fi 
# ????????????????????
age=10
if [ "$age" -gt 18 -a "$age" -lt 40 ]; then
    echo Age is correct
else
    echo Age is not correct
fi 
# ????????????????????
age=30
if [ "$age" -gt 18 -o "$age" -lt 40 ]; then
    echo Age is correct
else
    echo Age is not correct
fi 
#
a="This is #1 my script!"
if [[ $a =~ [0-9]+ ]]; then
    echo "There are numbers in string: $a"
else
    echo "There are no numbers in string: $a"
fi
# case
a=dog
case $a in
    cat) echo "Feline";;
    dog|puppy) echo "Canine";;
    *) echo "No match!";;
esac
# # # ===============================================================
# # # functions
# # # ===============================================================
function greet {
    echo "Hi there!"
}
echo "And now, a greeting!"
greet
#
function greet {
    echo "Hi, $1! What a nice $2"
}
echo "And now, a greeting!"
greet User Morning
greet Everybody Evening
#
function numberthings {
    i=1
    for f in $@; do
        echo $i: $f
        ((i+=1))
    done
}
numberthings $(ls)
numberthings one two three
# ??????????????
function funcCheck() {
    returnValue="Some func return"
    echo "$returnValue"
}
funcCheck # Some func return
# ???????????????
fn() {
    returnValue="Linux"
}
returnValue="Mac"
echo "$returnValue" # Mac
fn 
echo "$returnValue" # Linux ## overwrite context

# # # ===============================================================
# # # loops
# # # ===============================================================
# ????????????????????
number=1
while [ $number -le 10 ]; do
    echo number:$number # 1-10
    number=$((number+1))
done
# ????????????????????
number=1
until [ $number -ge 10 ]; do
    echo number:$number # 1-9
    number=$((number+1))
done
# shortcut
i=0
while [ $i -lt 10 ]; do
    echo i:$i # 0-10
    ((i+=1))
done
j=0
while [ $j -lt 10 ]; do
    echo j:$j # 0-9
    ((j+=1))
done
#
for i in 1 2 3
do
    echo $i
done
# range
for i in {1..100} 
do
    echo $i
done
# interval in range
for i in {1..100..2}
do
    echo $i
done
# classic approach
for (( i=1; i<=10; i++ ))
do
    echo $i
done
# ????????????????????????
for (( i=1; i<=10; i++ ))
do
    if [ $i -gt 5 ]; then break fi
    echo $i # 1-5
done
# ????????????????????????
for (( i=1; i<=5; i++ ))
do
    if [ $i -eq 2 ] || [ $i -eq 4 ]; then continue fi
    echo $i # 1 3 5
done
# command
for i in $(ls)
do
    echo "$i"
done
# # # ===============================================================
# # # script arguments
# # # ===============================================================
# . scriptname OR source scriptname
echo $0; # /bin/bash
# sh scriptname
echo $0; # /path/scriptname 
### with execution right ###
# ./scriptname
echo $0; # /path/scriptname 
# ./scriptname Apple Lemon
echo $0 $1 # /path/scriptname Apple
# ./scriptname "Red Apple" "Yellow Lemon"
echo $1 $2 # Red Apple Yellow Lemon
# ./scriptname apple orange banana kiwi lemon
for i in $@
do
    echo $i
done
echo "There were $# arguments."
# ?????????????????????? ./scriptname Apple Lemon
args=("$@")
echo ${args[0]} ${args[1]}
# ?????????????????????
while read line
do
    echo "$line"
done < "${1:-/dev/stdin}"
# ./scriptname -u user -p pass
while getopts u:p: option; do
    case $option in
        u) user=$OPTARG;;
        p) pass=$OPTARG;;
    esac
done
echo "User: $user / Pass: $pass"

# ./scriptname -u user -p pass -a -b
while getopts u:p:ab option; do
    case $option in
        u) user=$OPTARG;;
        p) pass=$OPTARG;;
        a) echo "Got the A flag";;
        b) echo "Got the B flag";;
    esac
done
echo "User: $user / Pass: $pass"

# ./scriptname -u user -p pass -a -b -z ## caught unknown param with : before u in ?)
while getopts :u:p:ab option; do
    case $option in
        u) user=$OPTARG;;
        p) pass=$OPTARG;;
        a) echo "Got the A flag";;
        b) echo "Got the B flag";;
        ?) echo "I don't know what $OPTARG is!";;
    esac
done
echo "User: $user / Pass: $pass"

# requiring arguments
if [ $# -lt 3]; then
  cat <<- EOM
  Multi-line
  Description
EOM
else
  # the program goes here
  echo "Username: $1"  
  echo "UserID: $2"  
  echo "Favorite Number: $3"  
fi
# # # ===============================================================
# # # menu
# # # ===============================================================
# built-in menu with number keys 
select option in "cat" "dog" "bird" "fish"
do
    echo "You selected $animal!"
    break
done

# built-in menu with number keys & with exit 
select option in "cat" "dog" "quit"
do
    case $option in
        cat) echo "Cats like to sleep.";;
        dog) echo "Dogs like to play catch.";;
        quit) break;;
        *) echo "I'm not sure what that is.";;
    esac
done
# ???????????
echo "press any key to continue"
while [ true ]; do read -t 3 -n 1
    if [ $? = 0 ]; then echo "you've terminated the script"; exit
    else echo "waiting for you to press th key sir!!!"
    fi
done

# # # ===============================================================
# # # user input
# # # ===============================================================
# simple silent prompt inputs
echo "What is your name?"
read name
echo "What is your password?"
read -s pass
read -p "What's your favorite animal?" animal
echo name: $name, pass: $pass, animal: $animal

# if input value is null
read -p "Favorite animal? " a
while [[ -z "$a" ]]; do
  read -p "I need an answer" a
done
echo "$a was selected"
# # ===============================================================
# provide default input value
read -p "Favorite animal? [cat] " a
while [[ -z "$a" ]]; do
  a="cat"
done
echo "$a was selected"
# # ===============================================================
# validate input value with regexp
read -p "What year? [nnnn] " a
while [[ ! $a = ~ [0-9]{4} ]]; do
    read -p "A year, please! [nnnn]"
done
echo "Selected year: @a"
# # ===============================================================
# # ===============================================================
# # ===============================================================
# ???????????????? helloScript.sh
MESSAGE="Hello"
export $MESSAGE
./secondScript.sh
# ???????????????? secondScript.sh
echo "The message from helloScript is: $MESSAGE"
# # ===============================================================
# ??????????????
$ declare myvar=123
$ declare -p
# ??????????????
declare -r pwdfile=/etc/passwd
echo $passwd
pwdfile=/etc/abc.txt # readonly variable

# ???????????????? curl 
url="http://www.ovh.net/files/1Mio.dat"
curl ${url} -o NewFileDw # download file
curl ${url} -I # http req headers
curl ${url} > outputfile # 

# echo -n "Enter to continue or Ctrl-C to quit: "
# read

# chmod 644 $file
# if [[ $0 == "/bin/bash" ]]; then
#   for i in 1 2 3 4
#   do
#     clear;
#     echo -e "Для правильной работы запускать скрипт через \nsh scriptname\n \tИЛИ \n/path/scriptname с правами на выполнение\n Осуществляется выход $((i*=25))%" ; 
#     read -t 1 -n 1;
#   done
#   # exit 255;
# fi;
# echo $(basename $0); # script

# replacing exact line w/ sed ## symbol \ itself will never be printed in sed
sed -i "341s/qqq/qwe # % ^ & + - * = > < ; | ' [] {} () " /path/filename; # as is
sed -i "341s/qqq/qwe \! \@ \$ \/ \:" /path/filename; # qwe ! @ $ / :"