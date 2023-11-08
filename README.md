# Encounter Sim

## Table of Contents
- [Project Links](#project-links)
- [System Dependencies](#system-dependencies)
- [Testing Dependencies](#testing-dependencies)
- [Installation Instructions](#installation-instructions)
- [Application Architecture](#application-architecture)
- [Summary of Work](#summary-of-work)
- [EncounterSim Screenshots](#encountersim-screenshots)
- [Contributors](#contributors)</br>

<h3 align="center">Project Description</h3>
<p align="center">
Encounter Sim allows a User to select a group of characters and simulate them battling a monster, utilizing the D&D 5th Edition ruleset. This webapp utilizes the dnd53api.co API to gather neccessary data on monsters and character classes.
Designed for use with EncounterSim-BE through parsing of JSON data.
</p></br>

## Project Links
- Deployed Sites
    - [Frontend](https://encountersim-fe-ea3ea78fa419.herokuapp.com/)
    - [Backend](https://encountersim-be-78e8d38428a7.herokuapp.com/)
- GitHub Repositories
    - [Frontend](https://github.com/EncounterSim/encounterSim-FE)
    - [Backend](https://github.com/EncounterSim/EncounterSim-BE)

## System Dependencies
- [EncounterSimBE](https://github.com/EncounterSim/encounterSim-FE)
- Faraday
- BCrypt
- Ruby (3.2.2) 
- Rails (7.1.1)
- Mailcatcher
- Kaminari

## Testing Dependencies
  - Pry
  - Rspec
  - Shoulda-Matchers
  - Simplecov
  - Capybara
  - VCR
  - Webmock
  - TimeCop

## Installation Instructions
 - Fork Repository
 - `git clone <repo_name`
 - `cd <repo_name>`
 - `bundle install`   
 - `rails db:{drop,create,migrate,seed}`
 - `rails s`
    - To Utilize Mailcatcher for Testing
        - `gem install mailcatcher`
        - In config/environments/development.rb
        - `$ mailcatcher` - Visit http://localhost:1080 to review received emails

## Application Architecture
- Frontend Service: Frontend codebase responsible for security, rendering user interface, handling user interactions and makes API service calls to the Backend for API data and Simulation logic return.
- Backend Service: Backend codebase is responsible for connecting directly with the dnd53api.co API and the logic processing for encounter simulations.
  - <strong>Architecture Reasoning</strong>: Frontend and Backend services can be updated and maintained independently which reduces the risk of affecting the entire system when changes are made on either side. This architecture setup has allowed for easier testing, adaptability and allows both teams to work simultaneously.

## Summary of Work
- Create an Account / Login Methods
  - Standard Login through email and password entry.
  - Login through Github with authenticaation using Oauth.
  - Passworldess Login through Emailed Magic Links.
- List of <strong>Monsters</strong> from D&D 5th Edition with detailed information from dnd53api.co API.
  - Pagination offers easy viewing of over 300 Monsters.
  - Information includes: Hit Points, Armor Class, Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma with list of attachs and descriptions.
- Create a D&D Monster Encounter Simulation:
  1. Choose a Monster for your Party
  2. Add attributes for up to 5 Characters in your Party. Choices include:
      - Class
      - Level
      - Strength Modifier
      - Dexterity Modifier
      - Constitution Modifier
      - Wisdom Modifier
      - Charisma Modifier
      - Intelligence Modifier
      - 3 spell slots
      - Hit points
      - Armor Class
      - Damage Dice.
  3. After clicking 'Create Encounter', EncounterSim-BE will run simulation and return a list of results:
      - Total Wins
      - Total Losses
      - Total Rounds
      - Total Combats Simulated
      - Win Percentage
      - Average Damage across all Combats for each Character
      - Average Hit Rate Across All Combats for each Character
      - Total Damage Across Simulation for each Character
      - Average Monster Damage
      - Average Monster Hit Rate
  4. Once a user logs in, they will have access to all their past simulations run with EncounterSim for later usage.

## EncounterSim Screenshots
<div style="display: flex; align-items: center;">
  <div style="margin-right: 20px;">
    <p><center>Login Page</center</p>
    <img src="https://raw.githubusercontent.com/EncounterSim/encounterSim-FE/63356698711b79d5321abd7d7fa8a3eb5d57c572/Screenshot%202023-11-07%20at%206.13.29%20PM.png" alt="Login Page" width="200" />
  </div>
  <div>
    <p><center>Monster Data Page</center></p>
    <img src="https://raw.githubusercontent.com/EncounterSim/encounterSim-FE/faa1d6ad27eea37a54edb4e3fed27b94383d4464/Screenshot%202023-11-07%20at%206.34.28%20PM.png" alt="Monster Data" width="600" />
  </div>
</div>

<div style="display: flex; align-items: center;">
  <div style="margin-right: 20px;">
    <p><center>Simulation Creation Page</center></p>
      <img src="https://raw.githubusercontent.com/EncounterSim/encounterSim-FE/main/Screen%20Shot%202023-11-07%20at%205.20.14%20PM.png" alt="Simulation Creation Page" width="400" />
  </div>
  <div>
    <p><center>Simulation Result Page</center></p>
    <img src="https://raw.githubusercontent.com/EncounterSim/encounterSim-FE/main/Screen%20Shot%202023-11-07%20at%205.41.38%20PM.png" alt="Simulation Result Page" width="400" />
  </div>
</div>


## Contributors
- Robert deLaguna [GitHub](https://github.com/rjdelaguna) | [LinkedIn](https://www.linkedin.com/in/robert-delaguna/)
- Kaylee Janes [GitHub](https://github.com/kbug819) | [LinkedIn](https://www.linkedin.com/in/kaylee-janes/)
- Connor Richmond [GitHub](https://github.com/ConnorRichmond) | [LinkedIn](https://www.linkedin.com/in/corichmond/)
- Nicholas Spencer [GitHub](https://github.com/deadbert) | [LinkedIn](https://www.linkedin.com/in/nicholas-spencer-fort-collins/)

## Endpoints
### Monster Endpoints:
#### GET "/api/v1/monsters" - returns a list of monsters
- Example Return: `{data =>[{:id=>nil, :type=>"monster", :attributes=>{:id=>nil, :name=>"Aboleth", :url=>"/api/monsters/aboleth", :index=>"aboleth"}}...]}`

#### Get "/api/v1/monsters/{monster_index} - return info on specific monster using `monster_index` value 
- example: "/api/v1/monsters/acolyte"
- ![Screenshot 2023-11-08 at 10 56 58 AM](https://user-images.githubusercontent.com/47225798/281498346-0d420d17-98d4-4bc1-820e-0d2fd77c459e.png)

### Player class endpoints
#### GET "/api/v1/players" - returns a list of the 12 base player classes
- Example Return: `{data => {:id=>nil, :type=>"player", :attributes=>{:id=>nil, :name=>"Barbarian", :url=>"/api/classes/barbarian", :index=>"barbarian"}}...}`

### Spells endpoints
#### GET "/api/v1/spells" - returns a list of base spells 
- Example Return: `{data => {:id=>nil, :type=>"spell", :attributes=>{:id=>nil, :name=>"Acid Arrow", :url=>"/api/spells/acid-arrow"}}...}`

### Encounters endpoints
#### GET "/api/v1/encounters" - returns list of Simulation id's for a user, accepts user id as a param
- Example Return: `{:data=>[{:id=>"6", :type=>"simulation", :attributes=>{:id=>6, :user_id=>2}}]}`

#### GET "/api/v1/encounters/{Simulation_id} - return encounter stats for simulation
- Example request: "/api/v1/encounters/3"

#### Post "/api/v1/encounters" - post request to create a new Encounter and run simulation, returns results of encounter in response body
- Requires encounter params in request body
- example request: ![Screenshot 2023-11-08 at 11 17 41 AM](https://user-images.githubusercontent.com/47225798/281503558-595d5a47-7be1-4888-8890-801d3715a075.png)

## DB Schema
<div>
  <img src="https://raw.githubusercontent.com/EncounterSim/EncounterSim-BE/main/Screenshot%202023-11-08%20at%2010.44.41%20AM.png" alt="DB Schema" width="600" />
</div>
