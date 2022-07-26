#!/bin/bash	

#Ayush Gupta               Roll no 33228
#L - 10 

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
YELLOW="\e[33m"

createf(){
	#echo "\n${YELLOW}***********************************************${ENDCOLOR}" 
	echo -e -n "${GREEN}\nEnter file name : ${ENDCOLOR}"
	read file_name

	# Checking if file already exists
	search=`ls | grep $file_name | wc -l` 
	
	if (( $search > 0 ))
	then
		fname=$file_name
		echo -e "${GREEN}Selected file named: $fname ${ENDCOLOR}"
	else
		fname=$file_name
		touch $fname.txt
		echo -e "${GREEN}Created file named: $fname ${ENDCOLOR}"
		 
		echo -e "${GREEN}MODELNO|TYPE|MODELNAME${ENDCOLOR}"  >> $fname.txt

	fi
}

displayf(){
	echo -e "\n${YELLOW}***********************************************${ENDCOLOR}" 
	echo -e "\n${GREEN}Current Address Book is shown below \n${ENDCOLOR}"
	cat $fname.txt | column -t -s "|" | sort
	echo -e "\n${YELLOW}***********************************************${ENDCOLOR}"
}

insertf(){
		echo -e "${YELLOW}***********************************************${ENDCOLOR}"
		echo -e "\nInserting a new Record${ENDCOLOR}" 
				
		echo -n "Enter Model no. : "
		while(true)
			do
				read modno
				if [ ${#modno} -gt 0 ]
				then
							
					break
				else
					echo -e "${RED}Model no. cannot be empty${ENDCOLOR}"
				fi 
			done
					
		echo -e -n "${GREEN}Enter type : ${ENDCOLOR}"
		read type
				
		echo -n -e "${GREEN}Enter model name : ${ENDCOLOR}"
		read mname
				
		echo -e "${GREEN}\nEntering record \n$modno \t $type \t $mname${ENDCOLOR}"			
		echo "$modno|$type|$mname" >> $fname.txt
}

deletef(){
	echo -e "${YELLOW}\n*********************************************${ENDCOLOR}" 
	echo -e -n "${GREEN}Enter the record to be deleted : ${ENDCOLOR}"
	read delrec
	flag=`cat $fname.txt | grep $delrec | wc -l`
	
	if [ $flag -eq 1 ] #checking valid Record
	then 
		deleted_item=`cat $fname.txt | grep $delrec`
		sed -i "/^$delrec/d" $fname.txt
			# Deleting Record
					
		echo -e "${GREEN}Record Deleted Successfuly\n Record: $deleted_item ${ENDCOLOR}"
				
	else
		echo -e "${RED}Entered Record doesn't exist!!!${ENDCOLOR}"
	fi
	echo -e "${YELLOW}\n*********************************************${ENDCOLOR}"
}

updatef(){
	echo -e "${YELLOW}\n*********************************************${ENDCOLOR}" 
	echo -e -n "${GREEN}Enter the Model no to be Updated : ${ENDCOLOR}"
	read uprec
	flag=`cat $fname.txt | grep $uprec | wc -l`
	
	if [ $flag -eq 0 ] #checking valid Record
	then 
		echo -e "${RED}Entered Model no doesn't exist, Check Again!!!${ENDCOLOR}"
	else
		old=`cat $fname.txt | grep $uprec`
		echo -e "${GREEN}Enter the following values to modify the record:${ENDCOLOR}"
		
		echo -e -n "${GREEN}Enter type : "
		read type
				
		echo -n -e "${GREEN}Enter model name : "
		read mname
				
		echo -e "${GREEN}\Updating record \n$uprec \t $type \t $mname"
	fi
	 
}

searchf(){
	echo -e "\n***********************************************" 
	echo -e -n "${GREEN}Enter the record to be searched : ${ENDCOLOR}"
	read searchRec
	grep $searchRec $fname.txt
	echo -e "***********************************************" 
}

exitf(){
	echo -e "${YELLOW}***********************************************${ENDCOLOR}"
	echo -e "                  Exiting                      "
	echo -e "${YELLOW}***********************************************${ENDCOLOR}"
}

createf

while(true)
	do
		# print the menu
		echo -e "\n${YELLOW}***********************************************${ENDCOLOR}" 
		echo -e "${YELLOW}|                  MENU                       |${ENDCOLOR}"
		echo -e "${YELLOW}***********************************************${ENDCOLOR}"
		echo -e "${YELLOW}|      1) Create or Select Address book       |${ENDCOLOR}"
		echo -e "${YELLOW}|      2) View Address book                   |${ENDCOLOR}"
		echo -e "${YELLOW}|      3) Insert a Record                     |${ENDCOLOR}"
		echo -e "${YELLOW}|      4) Delete a Record                     |${ENDCOLOR}"
		echo -e "${YELLOW}|      5) Update a Record                     |${ENDCOLOR}"
		echo -e "${YELLOW}|      6) Search a Record                     |${ENDCOLOR}"
		echo -e "${YELLOW}|      7) Exit                                |${ENDCOLOR}"
		echo -e "${YELLOW}***********************************************${ENDCOLOR}"
		echo -e -n "${GREEN}\nEnter your choice : ${ENDCOLOR}"
		read choice
		
		#switch case
		case "$choice" in
			1)
				createf
			;;
			
			2) 
				displayf 
			;;
				
			3)
				insertf
			;;
			
			4)
				deletef 
			;;

			5)
				updatef
			;;
			
			6)
				searchf
			;;
			
			7)
				exitf
				break
			;;

			*)
				echo -e "${RED}Invalid Input!!!${ENDCOLOR}"
			;;	
		esac
	done
