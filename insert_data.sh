#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams")

# Read through .csv file and set variables to corresponding columns
tail -n +2 games.csv | while IFS="," read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

  # Check to see if winner needs to be added to 'teams' table
  if [[ $WINNER != winner ]]
  then

    # Check if winner is already in 'teams' table
    TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name = '$WINNER'")

    # If winner not found...
    if [[ -z $TEAM_ID ]]
    then

      # Insert missing winner name into the 'teams' table.
      INSERT_WINNER=$($PSQL "INSERT INTO teams (name) values ('$WINNER')")
      
      # Print results to terminal
      if [[ $INSERT_WINNER == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi

      # Get new team_id
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")

    fi
  fi

  # Check to see if opponent needs to be added to 'teams' table
  if [[ $OPPONENT != opponent ]]
  then
    # Check if opponent is already in 'teams' table
    TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name = '$OPPONENT'")

    # If opponent not found...
    if [[ -z $TEAM_ID ]]
    then

      # Insert missing opponent name into the 'teams' table.
      INSERT_OPPONENT=$($PSQL "INSERT INTO teams (name) values ('$OPPONENT')")
      
      # Print results to terminal
      if [[ $INSERT_OPPONENT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi

      # Get new team_id
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    fi

  fi

  echo Data from games.csv successfully added to teams table!

  # Add the info from csv into the 'games' table
  # Get game_id from 'games' table
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'") 
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
  GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year = $YEAR AND round = '$ROUND' AND winner_id = '$WINNER_ID' AND opponent_id = '$OPPONENT_ID'")

  # If game_id not found...
  if [[ -z $GAME_ID ]]
  then

    # Insert row into 'games' table
    INSERT_GAME=$($PSQL "INSERT INTO games (year, round, winner_id, winner_goals, opponent_id, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $WINNER_GOALS, $OPPONENT_ID, $OPPONENT_GOALS)")
    
    # Print results to terminal
    if [[ $INSERT_GAME == 'INSERT 0 1' ]]
    then
      echo "Inserted into games, $YEAR - '$ROUND', '$WINNER' $WINNER_GOALS-$OPPONENT_GOALS > '$OPPONENT'"
    fi

  fi

  echo Data from games.csv successfully added to 'games' table!

done
