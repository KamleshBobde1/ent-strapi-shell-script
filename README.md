# ent-strapi-shell-script
## The shell script to automate strapi project creation with customized code. Postgres database is required.

### Prerequisites:
 - Create a database in Postgres for Strapi project.
 - Keep the database name, username, password, ip address and database port handy.
 - Keep realm name (Ex. entando) and App Builder url (Ex. http://192.168.43.3.nip.io) handy.
 - Keep machine IP(Ex. 172.40.0.142) and port (Ex. 1337) handy where strapi project will run on.
### Steps to follow with the script:
1. Pull the script from repo:
  $ `git clone https://github.com/KamleshBobde1/ent-strapi-shell-script.git`
2. $`cd ent-strapi-shell-script`
3. Hit the script `ent-strapi-shell-script $./strapi-start.sh`
  - It will start strapi project creation and will prompt for some details.
4. Choose your installation type (Use arrow keys)
    `Custom (manual settings)`
5. Choose your default database client (Use arrow keys)
    `postgres`
6. Database name: (strapi-by-script)
    `strapi-db` (For example)
7. Host: (127.0.0.1) press enter
8. Port: (5432) press enter
9. Username: enter db username
10. Password: enter db password
11. Enable SSL connection: (y/N) `N`
 - project creation starts
12. Enter realm name (Ex: entando): enter realm name
13. Enter app builder url (Ex: http://192.168.43.3.nip.io): enter app builder url
  - script exectution goes ahead
  - It may take few minutes to build Admin UI with development congigurations.
14. Once `http://localhost:1337/admin` message is appeared, go to this link and create your first administrator 💻 by going to the administration panel at: http://localhost:1337/admin
15. Login, go to Admin panel and set a username for Admin user.
16. This shell script will create a strapi project under dir: `strapi-by-script415`
