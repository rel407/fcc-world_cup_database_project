# World Cup Database

This project involves creating a PostgreSQL database to store and analyze historical match data from the FIFA World Cup tournaments (2014 and 2018). The project includes two main bash scripts: one for populating the database with data from a CSV file and another for running various queries to analyze the data.

## Project Overview

1. **CSV Data**: The data consists of match results from the 2014 and 2018 World Cups, including:
   - `year`: Year the match was played.
   - `round`: Round of the match (e.g., Final, Semi-Final).
   - `winner`: Team that won the match.
   - `opponent`: Team that lost the match.
   - `winner_goals`: Number of goals scored by the winning team.
   - `opponent_goals`: Number of goals scored by the losing team.

2. **Database Schema**: 
   - **teams table**: Stores team information.
   - **games table**: Stores match data, linking to the teams using team IDs.

3. **Bash Scripts**:
   - **First script**: Populates the database with teams and game data from the CSV.
   - **Second script**: Runs queries to analyze the data, providing answers to questions such as total goals, average goals, and more.

## Setup Instructions

### 1. Set Up PostgreSQL Database

Ensure that you have PostgreSQL installed and running. If not, install PostgreSQL from the [official website](https://www.postgresql.org/download/).

Create a new database:
```
createdb worldcup
```

### 2. CSV File

Download or place the `games.csv` file containing the match data into the project directory.

### 3. Running the Scripts

#### Script 1: Setting Up the Database

This script populates the `teams` and `games` tables with data from the CSV file. It ensures that any teams not already in the database are added before inserting the match data.

To run this script:
```
bash script1.sh
```

This script performs the following:
- Reads through the CSV file (`games.csv`).
- Adds new teams to the `teams` table if they don't already exist.
- Inserts match data into the `games` table.

#### Script 2: Running Queries

This script runs a series of queries to analyze the World Cup data, answering various questions related to the matches.

To run the script:
```
bash script2.sh
```

### 4. Sample Output

#### Example 1: Total Number of Goals from Winning Teams
```
Total number of goals in all games from winning teams:
160
```

#### Example 2: Average Number of Goals in All Games
```
Average number of goals in all games from the winning teams:
2.35
```

#### Example 3: Teams Who Played in the 2014 'Eighth-Final' Round
```
List of teams who played in the 2014 'Eighth-Final' round:
Brazil
Colombia
France
Germany
...
```

#### Example 4: Teams That Start With 'Co'
```
List of teams that start with 'Co':
Colombia
Costa Rica
```

## Project Structure
```
├── games.csv               # CSV file containing World Cup match data
├── script1.sh              # Bash script to set up and populate the database
├── script2.sh              # Bash script to query and analyze the database
└── README.md               # Project documentation
```

## Technologies Used
- **PostgreSQL**: For managing and querying the database.
- **Bash**: For scripting the database setup and queries.
- **CSV**: For storing match data.

## License

This project is open-source and available under the MIT License.
