#!/bin/bash
#I needed to do a mass naming convention fix on hundreds of resources
#The third sed command accomplished what I needed it to do but terraform has varying levels of indentation/tabs
#which was messing up the script- thus I had to normalize all white spaces and terraform fmt when changed


for file in $(find . -name "*.tf");
do
sed -i 's/\([^[:space:]]\)[[:space:]]\{1,\}/\1 /g; s/[[:space:]]*$//' "$file"
sed -i 's/^[ \t]*//' "$file"
sed -i 's/^\( *name *= *"\)${var.app_name}-${var.app_env}-\(.*\)"/\1\2-${var.app_env}"/i' "$file"
done

terraform fmt -recursive

