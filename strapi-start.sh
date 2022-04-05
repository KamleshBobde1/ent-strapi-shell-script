#!/bin/bash 
echo "Strapi installation started" 
npx create-strapi-app@latest strapi-by-script
#npx create-strapi-app strapi-by-script --quickstart 

echo "Strapi installation complete"

#Take realm name and app builder url from user
echo "Enter realm name (Ex: entando) "
read REALM_NAME

echo "Enter app builder url (Ex: http://192.168.43.3.nip.io):"
read APP_BUILDER_URL

#The repository which has customized strapi code.
 REPO=https://github.com/KamleshBobde1/strapi-customized.git
 echo "git cloning customized code from $REPO"
 git clone $REPO
 echo "git cloned customized code"

#Copy users-permissions folder from cloned code to strapi project src folder
 echo "Copying users-permissions plugin to strapi project"
 cp -R strapi-customized/users-permissions strapi-by-script/src/extensions/
 echo "Copied users-permissions plugin to strapi project"

#-- Edit file with dynamic real and app builder url in users-permissions
 sed -i 's~entando~'$REALM_NAME'~g' strapi-by-script/src/extensions/users-permissions/server/services/jwt.js
 sed -i 's~http://192.168.43.3.nip.io~'$APP_BUILDER_URL'~g' strapi-by-script/src/extensions/users-permissions/server/services/jwt.js
 echo "Realm name and app builder set in users-permissions plugin"
 
#Go to users-permissions directory and invoke npm install command
 cd strapi-by-script/src/extensions/users-permissions
 echo "Changed directory to strapi-by-script/src/extensions/users-permissions"
 echo "install the dependencies by npm install in users-permissions"
 npm install
 
 pwd
 cd ../../../..
 pwd
 
#Delete existing strapi-by-script/src/admin
 rm -rf strapi-by-script/src/admin
 echo "existing strapi-by-script/src/admin folder deleted"
 
 pwd
#Copy admin folder from cloned code to strapi project src folder 
 echo "Copying admin module to strapi project"
 cp -R strapi-customized/admin/ strapi-by-script/src/
 echo "Copied admin module to strapi project"
 
#Move to src/admin
 echo "Changed directory to strapi-by-script/src/admin"
 cd strapi-by-script/src/admin
 echo "pwd: "
 pwd 
 
#-- Edit file with dynamic real and app builder url in admin module
 sed -i 's~entando~'$REALM_NAME'~g' server/services/token.js
 sed -i 's~http://192.168.43.3.nip.io~'$APP_BUILDER_URL'~g' server/services/token.js
 echo "Realm name and app builder set in admin module"

# install dependencies 
 echo "installing the dependencies by npm install in admin"
 npm install
 
#Move back to project directory
 cd ../..
 pwd
 
#Replace the correct path of admin module
 sed -i 's~@strapi/admin/strapi-server~../../../../../../src/admin/strapi-server~g' node_modules/@strapi/strapi/lib/core/loaders/admin.js

#Delete to cloned directory, move back to parent dir
 cd ..
 pwd
 rm -rf strapi-customized
 echo "deleted cloned customized plugins folder"
 cd strapi-by-script
 echo "starting strapi server by npm run develop"
 
#Start the strapi server
 npm run develop
 
