#!/bin/bash


declare -i count
declare -i admin


menuSelect=""
temp=""


uname=""
paswrd=""


enterName=""
enterPass=""


count=0
admin=0


cont=""
contAdd=""
contNum=""
contPass=""
contAdmin=""


contGet=""
contNumSet=""


echo sup


while (($count == 0))
do
	echo -------------------------------------
	echo Welcome to the Group Login Program
	echo -------------------------------------
	echo Please enter your username\:
	read uname
echo -------------------------------------


	enterName=$(grep "$uname" ~/Desktop/scripts/udata/user_list.txt)


	echo Please enter your password\:
	read paswrd
	echo -------------------------------------


	if [ "$enterName" ];
    	then
    	echo $enterName > ~/Desktop/scripts/udata/temp.txt
    	enterPass=$(awk '{print $4}' ~/Desktop/scripts/udata/temp.txt)
    	if [ "$enterPass" = "$paswrd" ];
        	then
    	clear
        	echo -------------------------------------
        	echo \ \ \ \ \ \ \ \ \ \ \ Welcome $uname
        	echo -------------------------------------
        	count=1


    	else
        	echo Sorry, wrong password.
    	fi


    
	else
    clear
    	echo Sorry, that user does not exist.
    	echo -------------------------------------
	fi
done


count=0




while (($count == 0))
do
echo -------------------------------------
echo -e '\t'Commands available to you
echo -------------------------------------


admin=$(awk '{print $6}' ~/Desktop/scripts/udata/temp.txt)
if [ $admin = "1"  ];
    	then
    	{
        	echo 1. Create user
        	echo 2. Change password
        	echo 3. Generate invoice
        	echo 4. Add contacts to device
        	echo 5. Place call
        	echo 6. Check device call log
        	echo 7. Check contacts
        	echo Please enter the number of the menu you wish to enter
    	read menuSelect
    
    case $menuSelect in
    1)
    	echo Please enter user name\:
    	read contAdd
    
    	echo Please enter user password\:
    	read contPass


    	echo Is User an admin? 1\/0\:
    	read contAdmin
    
    	cont="Username\s" $contAdd "\s password \s" $contPass "\s admin \s" $contAdmin "\n"
   	 
    	$cont >> ~/Desktop/scripts/udata/user_list.txt
   	 touch ~/Desktop/scripts/udata/call_log/"$contAdd.txt"
   	 touch ~/Desktop/scripts/udata/contacts/"$contAdd.txt"
   	 touch ~/Desktop/scripts/udata/invoice/"$contAdd.txt"
    
   	 
    ;;
    2)
    temp=$uname
    while (($count == 0))
    do
   	 echo -------------------------------------
        	echo Please enter the username\:
        	read uname
   	 echo -------------------------------------    
    
        	enterName=$(grep "$uname"  ~/Desktop/scripts/udata/user_list.txt)
    
   	 
    
   	 if [ "$enterName" ];
        	then
   	 {
   		 echo -------------------------------------
       		 echo Please enter old password\:
       		 read paswrd
       		 echo -------------------------------------
           		 echo $enterName > ~/Desktop/scripts/udata/temp.txt
           		 enterPass=$(awk '{print $4}' ~/Desktop/scripts/udata/temp.txt)
           		 if [ "$enterPass" = "$paswrd" ];
                	then
   		 {
               		 echo -------------------------------------
               		 echo Enter new password \for $uname
               		 echo -------------------------------------
               		 read $temp    
           	 
          				 while (awk "{print $4}" = $paswrd)
   			 do
           			 	if [["$temp"=~[^a-zA-Z0-9]]];
           		         	then
   				 {
           		    		 echo valid
   				 sed -e 's/$paswrd/$temp/g'~/Desktop/scripts/udata/user_list.txt  
   				 }
   	           		 	else
   				 {
          		    			 echo invalid
   				 }
           			 	fi
           			 done  
                	count=1
   		 }
    
            	else
   		 {
                	echo Sorry, wrong password.
   		 }    
   	 	fi


   	 }   	 
        	else
   	 {
            	echo -------------------------------------
            	echo Sorry, that user does not exist.
            	echo -------------------------------------
   	 }
        	fi
    
    done
    
    count=0
    uname=$temp
    temp=""
    ;;
    
    3)
   		 echo Do you want to create an invoice? \(Y\/n\)
   		 read temp
    
   	 if [[$temp -eq Y] || [$temp -eq y]];
   		 then
   	 {
       		 "1" > ~/Desktop/scripts/udata/invoice/htp.txt
   	 }
    
   		 elif [[$temp -eq N] || [$temp -eq n]];
   		 then
   	 {
       		 echo Okay, maybe some other time.
   	 }
    
   		 else
   	 {
       		 echo Invalid input, please try again.
   	 }


   	 fi
    ;;
    
    4)
   		 echo Please enter contact name\:
   		 read contAdd
    
   		 echo Please enter contact number\:
   		 read contNum
    
   		 cont=(wc -l ~/Desktop/scripts/udata/contacts/$uname\_contacts.txt)".\s" $contAdd "\sNumber\s" $contNum\n
   	 
   		 $cont >> ~/Desktop/scripts/udata/contacts/$uname\_contacts.txt
    ;;
    
    5)
   	 echo Please enter the name of the person you are calling
   	 read temp
    
   	 $temp >> ~/Desktop/scripts/udata/call_log/$uname".txt"
   	 '1' >> ~/Desktop/scripts/udata/invoice/$uname".txt"
    ;;
    
    6)
   	 echo Please the name of the user to check their call log\:
   	 read temp
    
   	 cat ~/Desktop/scripts/udata/call_log/"$temp.txt"
    ;;
    
    7)    
   		 echo Please enter the name of the user you want to check the contacts of\:
   	 read temp
   	 
   	 cat ~/Desktop/scripts/udata/contacts/$temp.txt
    ;;
    
    *)
   	 echo invalid input
    ;;
    esac
}
else
{
    	echo 1. Add contacts to device
        	echo 2. Place call
        	echo 3. Check device call log
        	echo 4. Check contacts
        	echo 5. Check invoice
        	echo 6. Pay bill
        	echo Please enter the number of the menu you wish to enter
        	read menuSelect


    case $menuSelect in
    1)
   	 	echo Please enter contact name\:
   	 	read contAdd
   	 
   	 	echo Please enter contact number\:
   	 	read contNum
   	 
   	 	cont=(wc -l ~/Desktop/scripts/udata/contacts/$uname\_contacts.txt)".\s" $contAdd "\sNumber\s" $contNum\n
   		 
   	 	$cont >> ~/Desktop/scripts/udata/contacts/$uname\_contacts.txt
   	 ;;


   	 2)
   		 echo Please enter the name of the person you are calling    
   		 read temp
   	 
   	 $temp >> ~/Desktop/scripts/udata/call_log/$uname".txt"
   	 "1" >> ~/Desktop/scripts/udata/invoice/$uname".txt"
   	 ;;
    
   	 3)
   	 	cat ~/Desktop/scripts/udata/call_log/$uname".txt"
   	 ;;
    
   	 4)
   	 	cat ~/Desktop/scripts/udata/contacts/$uname".txt"
   	 ;;
    
   	 5)
   	 	cat ~/Desktop/scripts/udata/invoice/$uname".txt"
   	 ;;
    
   	 6)
   	 	echo Your invoice is\:
   	 	grep -i ~/Desktop/scripts/udata/invoice/$uname".txt"
   	 
   	 	echo do you want to pay the bill Y or n
   	 	read $temp
   	 
   	 	if [[$temp -eq Y] || [$temp -eq y]];
   	 	then
   			 {
   			 	cat "" > ~/Desktop/scripts/udata/invoice/$uname".txt"
   			 }


   	 	elif [[$temp -eq N] || [$temp -eq n]];
   	 	then
   			 {
   			 	echo Okay, maybe some other time.
   			 }


   	 	else
   			 {
   			 	echo Invalid input, please try again.
   			 }
   	 	fi
   	 ;;
    


    *)
   	 echo invalid input
    ;;
    esac
}
fi
echo
temp=""
done






