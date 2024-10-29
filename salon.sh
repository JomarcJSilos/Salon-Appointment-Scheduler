#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Shop ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How may I help you?" 
  echo -e "\n1) cut\n2) perm\n3) color\n"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUT ;;
    2) PERM ;;
    3) COLOR ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

CUT() {
  #get service_id number
  
  if [[ -z $SERVICE_ID_SELECTED ]]
  then
    # return user to menu
    MAIN_MENU "Choose valid service please!"
  else
    # ask customer for their number
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_PHONE_CHECK=$($PSQL "SELECT * FROM customers where phone = '$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_PHONE_CHECK ]]
    then
      # ask customer for their name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # insert customer info
      ADD_CUSTOMER=$($PSQL"INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      # ask customer for their desired appt time
      echo -e "\nWhat time would you like your cut,$CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers where phone = '$CUSTOMER_PHONE'")
      ADD_APPOINTMENT=$($PSQL"INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")

      # confirm with customer their appt time
    else 
      # ask customer for their desired appt time
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers where phone = '$CUSTOMER_PHONE'")
      
      echo -e "\nWhat time would you like your cut,$CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers where phone = '$CUSTOMER_PHONE'")
      ADD_APPOINTMENT=$($PSQL"INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")
    fi

    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ |/"/')
    SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
        
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."

  fi
}

PERM() {
  #get service_id number
  
  if [[ -z $SERVICE_ID_SELECTED ]]
  then
    # return user to menu
    MAIN_MENU "Choose valid service please!"
  else
    # ask customer for their number
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_PHONE_CHECK=$($PSQL "SELECT * FROM customers where phone = '$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_PHONE_CHECK ]]
    then
      # ask customer for their name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # insert customer info
      ADD_CUSTOMER=$($PSQL"INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      # ask customer for their desired appt time
      echo -e "\nWhat time would you like your perm,$CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers where phone = '$CUSTOMER_PHONE'")
      ADD_APPOINTMENT=$($PSQL"INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")

      # confirm with customer their appt time
    else 
      # ask customer for their desired appt time
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers where phone = '$CUSTOMER_PHONE'")
      
      echo -e "\nWhat time would you like your perm,$CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers where phone = '$CUSTOMER_PHONE'")
      ADD_APPOINTMENT=$($PSQL"INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")
    fi

    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ |/"/')
    SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
        
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."

  fi
}

COLOR() {
  #get service_id number
  
  if [[ -z $SERVICE_ID_SELECTED ]]
  then
    # return user to menu
    MAIN_MENU "Choose valid service please!"
  else
    # ask customer for their number
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_PHONE_CHECK=$($PSQL "SELECT * FROM customers where phone = '$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_PHONE_CHECK ]]
    then
      # ask customer for their name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      # insert customer info
      ADD_CUSTOMER=$($PSQL"INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      # ask customer for their desired appt time
      echo -e "\nWhat time would you like your color,$CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers where phone = '$CUSTOMER_PHONE'")
      ADD_APPOINTMENT=$($PSQL"INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")

      # confirm with customer their appt time
    else 
      # ask customer for their desired appt time
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers where phone = '$CUSTOMER_PHONE'")
      
      echo -e "\nWhat time would you like your color,$CUSTOMER_NAME?"
      read SERVICE_TIME

      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers where phone = '$CUSTOMER_PHONE'")
      ADD_APPOINTMENT=$($PSQL"INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME')")
    fi

    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ |/"/')
    SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ |/"/')
        
    echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."

  fi
}

MAIN_MENU