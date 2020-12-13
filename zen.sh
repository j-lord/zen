#####################################################################                                                                                                  
# * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - * #                                                                                                  

          ####     ####         Stay calm, Remain relaxed,
         ######   ######                                Keep ZEN
        ######## ########
        #################
        #################
          ###############
           #############
             ##########         This script was crafted using the
              ########                            finest Itanian leather
                ######
                 ####                                      ... and love
                   ##
                    #
                     #

# * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - * #                                                                                                  
#####################################################################
# If on Mac, change MY_NUMBER, group names, and group numbers. 
# make file exacutable  

#!/bin/bash
MY_NUMBER="+13334567778"
scriptName=zen.sh
#
# GROUPS, NAMES, and NUMBERS (like a sudo map)
ladies=("Amy":"+123" "Brittany":"+234" "Dana":"+345" "Lisa":"+456")
family=("Gma":"+987" "Mom":"+876" "Dad":"+765" "Aunt Sandy":"+654")
mates=("Dominic":"+111" "Jeremy":"+222" "Thomas":"+333" "Matt":"+444")
number_of_groups=3
# group 0=ladies 1=family 2=mates
#
# gounp_name=("Name":"+countryCodePhone_number" "Name"...and so on)
#
# to add a group, add info here under the last group and 
# advance number_of_groups + 1

############# Pick random Group and random Person #############
target_group=$[ RANDOM % number_of_groups ]

if   [ $target_group -eq 0 ]; then
  	person_index=$[$RANDOM % ${#ladies[@]}];
  	target_name=${ladies[person_index]}; 
elif [ $target_group -eq 1 ]; then 
  	person_index=$[$RANDOM % ${#family[@]}];
  	target_name=${family[person_index]};  
elif [ $target_group -eq 2 ]; then 
  	person_index=$[$RANDOM % ${#mates[@]}];
  	target_name=${mates[person_index]};
# .
# .
# elif [ $target_group -eq N ]; then 
#   	person_index=$[$RANDOM % ${#GROUPNAME[@]}];
#   	target_name=${GROUPNAME[person_index]};
else 
	echo "Error!"
	echo "Make sure you really have ${number_of_groups} groups?"
fi
###############################################################

name=${target_name%%:*}  # information preceding colon -> name:
number=${target_name#*:} # information following colon -> :number

###################   Messsage database  #######################
# Current hour
hourNow="$(date +%H)";

# shell will interpret hourNow as an octal number (with leading 0) 
# to avoid this, remove the leading zero using parameter expansion.
hourNow=${hourNow#0}

# add all time depended variables here
if (( hourNow >= 6 ))  && (( hourNow < 12 )); then
    time_of_day="morning";	HHH="have";	GGG="is"; TTT="tonight";
 
  elif (( hourNow >= 12 )) && (( hourNow <= 17 )); then 
    time_of_day="afternoon";HHH="are having"; GGG="is going"; TTT="later";

  elif (( hourNow >= 17 )) && (( hourNow <= 24 )); then 
    time_of_day="evening";  HHH="had"; 	GGG="has been"; TTT="";
fi
# this assumes no messages will be sent from 12 midnight to 6:00 am

# Will be working on building a larger message database
ladies_start=( "Good $time_of_day" "Hey $name" "What's up $name," 
	"I've been thinking about you all $time_of_day," "Just wanted to tell you" 
	"I just texted to say" "Good $time_of_day love,")
ladies_end=( "I miss you." "I hope that you ${HHH} a great day." 
	"I hope that your day ${GGG} great." "you're really great, I hope you know that." 
	"I can't wait to see you." "you have a way of making me smile no matter what." "you're beautiful.")
family_start=( "Good $time_of_day" "Hey $name" "I've been meaning to call you" )
family_end=( "I hope all has been well at home." 
	"I will be home later next month love you." "let's talk sometime next week, are you free any time?" )
# male punctuation use tends to be more so grammerically inconsistent
mates_start=("Good day sir" "Hey" "What's up" "Yo")
mates_end=("what's going on $TTT" "what are you doing later?" 
	"are we going out tonight?" "how's everything been going.")
#################################################################

################# Build random message  #########################
messageCode=$target_group; 
# generate message beginning and ending
# wanted to simply state beginning=$[ $RANDOM % ${#random_group[@]} ];
# but I was unable to find an elegant solution to a bash-type 2D array

case $messageCode in  # case (group number) in all
	0) 
			begining=$[ $RANDOM % ${#ladies_start[@]} ];      
			endning=$[ $RANDOM % ${#ladies_end[@]} ];
			# assigns begining/ending index
			random_beginning=${ladies_start[$begining]};
			random_ending=${ladies_end[$endning]};
			# assigns begining/ending messages
			;;
	1) 
			begining=$[ $RANDOM % ${#family_start[@]} ];      
			endning=$[ $RANDOM % ${#family_end[@]} ];
			random_beginning=${family_start[$begining]};
			random_ending=${family_end[$endning]};
			;;
	2)
			begining=$[ $RANDOM % ${#mates_start[@]} ];      
			endning=$[ $RANDOM % ${#mates_end[@]} ];
			random_beginning=${mates_start[$begining]};
			random_ending=${mates_end[$endning]};
			;; 
     *)
			echo "Error!"
			echo "Make sure you really have ${number_of_groups} groups?"
			;;
esac

sentence="${random_beginning} ${random_ending}" 
#the space between beginning ^ and ending puts the space between the two 
# parts of the sentences this is by far the most important space to have ever existed. 

# this gets the current directory that the icon is located in                                                                                                  
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd):zen.png"
# this says take directory name dir replace all occurances of (//) with (/)                                                                                    
dir=${dir////:}
##################################################################                                                                                                                        

########## The Following Takes advantage of Apple's osascript ##########
#### This will work only if you are on a mac and logged into your iCloud account
osascript <<EOD                                                                                                                                                                           
 tell application "Finder"
        activate
                (display dialog "To: $name $number \n $sentence" ¬
                        with title "Zen" ¬
                        with icon file "$dir" ¬
                        buttons {"Send", "ReDo", "Nah"} ¬
                        default button 1)
 end tell
                if result = {button returned:"Send"} then
                        tell application "Messages"
                                send "$sentence" to buddy "$number" of (service 1 whose service type is iMessage)
                        end tell
                else if result = {button returned:"ReDo"} then
                        do shell script "./$scriptName ~"
                else
                        (display dialog "Message Canceled" ¬
                        with title "Zen" ¬
                        buttons {"OK"} ¬
                        giving up after 2)
                end if
EOD

# silences the exacution error that occurs when reDo is hit 
eval >&/dev/null

######################################################################

# Can Send actual message a couple of other ways

# 1. Using Twilio  --> number format +15556667777
# curl -X POST 'https://api.twilio.com/2010-04-01/Accounts/ACCOUNTNUMBER/Messages.json' \
# --data-urlencode "To=$number"  \
# --data-urlencode "From=$MY_NUMBER"  \
# --data-urlencode "Body=${sentence}"  \
# -u ACba25802cbbd29f1ec807f26a429abfcc:AUTHORIZATIONTOKEN <-- get from site

# Twilio pros: Complete abstraction,  absolute flexability
# cons: there is a fee but its only $1.00 a month + $0.0075 per message
# 50 messages a week would cost ($1.00 + $0.0075*200) = $2.50 / month
# https://www.twilio.com/sms/pricing

# 2. Using textbelt --> number format 5556667777

# curl -X POST http://textbelt.com/text \
# -d number=${MY_NUMBER} \
# -d "message=${sentence}"

# textbelt pros: Quick and effortless
# cons: messages look HORRIBLE. If the goal is complete abstraction 
# this is not your choice. Its better for sending reminders or 
# notifications to yourself
# http://textbelt.com/#sthash.mtXpg60r.dpuf

# 3. using Apple Script (If on mac)
# directions above
# Apple Script pros: complete intergration of the system along with 
# notification plane. Take advantage of the ability to send iMessages.
# cons: can only be used on Mac.
