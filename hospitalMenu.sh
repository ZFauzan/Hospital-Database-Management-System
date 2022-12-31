#!/bin/sh

trap '' 2

while [ "$CHOICE" != "START" ]
do
	clear
	echo "================================================================="
	echo "|              Hospital Management Database System              |"
	echo "|                        CPS510 Group #109                      |"
	echo "|                                                               |"
	echo "|            Main Menu - Select Desired Operation(s):           |"
	echo "|        <CTRL-Z Anytime to Enter Interactive CMD Prompt>       |"
	echo "-----------------------------------------------------------------"
	echo " "
	echo " $IS_SELECTED1 1)  View Manual"
	echo " $IS_SELECTED2 2)  Drop Tables"
	echo " $IS_SELECTED3 3)  Create Tables"
	echo " $IS_SELECTED4 4)  Populate Tables"
	echo " $IS_SELECTED5 5)  Query Tables"
	echo " $IS_SELECTED6 6)  Show Views"
	echo " $IS_SELECTED7 7)  Search Tables"
	echo " $IS_SELECTED8 8)  Update Tables"
	echo " $IS_SELECTED9 9)  End/Exit"

	echo " "
	echo "Choose: "

	read CHOICE
	echo " "

	case "$CHOICE" in
		1) echo "Welcome to our Hospital Management Database System!\n\nTeam Members:\nFatima Jawed                #500939913\nZunaira Fauzan              #500975247\nHamdia Abdulhafiz Abdullahi #500975140" 
		   echo "\n\nHow to Use This Program?:\nType one of the numbers above to show the related results for our hospital database. Each number above automatically displays 1+ results (e.g., To drop ALL available tables, simply type '2' and hit 'Enter'. The results will be shown below. To return to the options and pick another number, simply press 'Enter' once again, then type the number."
		   echo "\nTo exit from our program, press 9 to return to your command prompt. Should you face any difficulties press 'Ctrl + Z' to force quit."
			;;
		2) bash drop_tables.sh ;;
		3) bash create_tables.sh ;;
		4) bash populate_tables.sh ;;
		5) bash query_tables.sh ;;
		6) bash show_view.sh ;;
		7) echo "Searching Patient Information: "
                   echo "=============================="
                   echo "Enter Patient Id: "
                   read PID
                   cat << EOF | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"

		   set wrap off
		   set linesize 150

--		   column PATIENT_ID format a55
		   column FIRST_NAME format a10
		   column LAST_NAME format a10
		   column NATIONALITY format a12
		   column GENDER format a6
		   column ADDRESS format a14
		   column date_of_birth format a15
--		   column phone_no format a30
		   column email_address format a18
--		   column room_no format a20

                   SELECT * FROM patient WHERE patient_id = ${PID};

EOF

                   ;;
		8) echo "Updating Patient Information: "
		   echo "=============================="
		   echo "Enter Patient Id: "
		   read ID
		   echo "Update Patient's New Address: "
		   read ADDRESS
		   echo "Update Patient's New Phone Number: "
		   read PNUM
		   echo "Update Patient's New Email Address: "
		   read EMAIL

		   cat << EOF | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"

		   UPDATE patient SET address = '${ADDRESS}', phone_no = '${PNUM}', email_address = '${EMAIL}' WHERE patient_id = ${ID};

EOF
		   
		   ;;
		9) exit ;;
	esac
		echo " "
		echo "Enter return to continue \c"
		read input
	done

#--COMMENTS BLOCK--
#  Main Program
#--COMMENTS BLOCK--

ProgramStart()
{
	StartMessage
	while [ 1 ]
	do
		MainMenu
	done
}

ProgramStart
