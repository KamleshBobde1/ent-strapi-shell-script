#!/bin/bash 

PROJECT_DIR=strapi-by-script415

echo "Strapi project creation started with name: $PROJECT_DIR"
sudo npx create-strapi-app@4.1.5 $PROJECT_DIR

echo "Strapi installation complete"

#Take realm name and app builder url from user
echo "Enter realm name (Ex: entando) "
read REALM_NAME

echo "Keycloak url (Ex: http://192.168.43.3.nip.io):"
read APP_BUILDER_URL

echo "Enter machine ip:(Ex: 172.40.0.142 OR localhost):"
read MACHINE_IP

echo "Enter port to run strapi on:(Ex: 1337):"
read PORT

echo "Updating machine ip and port in .env and config/server.js"
#Update ip and port in .env and config/server.js files
 sed -i 's~0.0.0.0~'$MACHINE_IP'~g' $PROJECT_DIR/.env
 sed -i 's~1337~'$PORT'~g' $PROJECT_DIR/.env
 
 sed -i 's~0.0.0.0~'$MACHINE_IP'~g' $PROJECT_DIR/config/server.js
 sed -i 's~1337~'$PORT'~g' $PROJECT_DIR/config/server.js
 
echo "Updated machine ip and port in .env and config/server.js"

#The repository which has customized strapi code.
 REPO=https://github.com/KamleshBobde1/strapi-customized.git
 echo "git cloning customized code from $REPO"
 
 git clone $REPO
 echo "git cloned customized code"


#Copy users-permissions folder from cloned code to strapi project src folder
 echo "Copying users-permissions plugin to strapi project"
 sudo cp -R strapi-customized/users-permissions $PROJECT_DIR/src/extensions/
 echo "Copied users-permissions plugin to strapi project"

#-- Edit file with dynamic real and app builder url in users-permissions
 sed -i 's~entando~'$REALM_NAME'~g' $PROJECT_DIR/src/extensions/users-permissions/server/services/jwt.js
 sed -i 's~http://192.168.43.3.nip.io~'$APP_BUILDER_URL'~g' $PROJECT_DIR/src/extensions/users-permissions/server/services/jwt.js
 echo "Realm name and app builder set in users-permissions plugin"
 
#Go to users-permissions directory and invoke npm install command
 cd $PROJECT_DIR/src/extensions/users-permissions
 echo "Changed directory to strapi-by-script/src/extensions/users-permissions"
 echo "install the dependencies by npm install in users-permissions"
 sudo npm install
 
 pwd
 cd ../../..
 pwd
 
#Hit npm run build in project dir
 echo "npm run build"
 sudo npm run build
 
# back to one dir
 cd ..
 pwd
 
#Delete existing strapi-by-script/src/admin
 sudo rm -rf $PROJECT_DIR/src/admin
 echo "existing strapi-by-script/src/admin folder deleted"
 
 pwd
#Copy admin folder from cloned code to strapi project src folder 
 echo "Copying admin module to strapi project"
 sudo cp -R strapi-customized/admin/ $PROJECT_DIR/src/
 echo "Copied admin module to strapi project"
 
#Move to src/admin
 echo "Changed directory to strapi-by-script/src/admin"
 cd $PROJECT_DIR/src/admin
 echo "pwd: "
 pwd 
 
#-- Edit file with dynamic real and app builder url in admin module
 sed -i 's~entando~'$REALM_NAME'~g' server/services/token.js
 sed -i 's~http://192.168.43.3.nip.io~'$APP_BUILDER_URL'~g' server/services/token.js
 echo "Realm name and app builder set in admin module"

# install dependencies 
 echo "installing the dependencies by npm install in admin"
 sudo npm install
 
#Move back to project directory
 cd ../..
 pwd
 
#Replace the correct path of strapi-server.js of src/admin
 sed -i 's~@strapi/admin/strapi-server~../../../../../../src/admin/strapi-server~g' node_modules/@strapi/strapi/lib/core/loaders/admin.js

#Delete to cloned directory, move back to parent dir
 cd ..
 pwd
 sudo rm -rf strapi-customized
 echo "deleted cloned customized plugins folder"
 cd $PROJECT_DIR
 
 #Start the strapi server by npm run develop
 echo "starting strapi server by npm run develop"
 sudo npm run develop
 
