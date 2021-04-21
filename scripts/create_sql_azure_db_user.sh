#!/bin/bash
echo 'Creating Login for user: ' $SQL_AZURE_USER_NAME
sqlcmd -S $SQL_AZURE_FQDN -U $SQL_AZURE_ADMIN_USER -P $SQL_AZURE_ADMIN_PASSWORD -d master -i ./scripts/create_sqlazure_login.sql -v SqlUserPassword=$SQL_AZURE_USER_PASSWORD -v SqlUserName=$SQL_AZURE_USER_NAME

echo 'Creating User with Role Assignments for Datbase: ' $SQL_AZURE_CONTENT_DB_NAME

sqlcmd -S $SQL_AZURE_FQDN -U $SQL_AZURE_ADMIN_USER -P $SQL_AZURE_ADMIN_PASSWORD -d $SQL_DB_NAME -i ./scripts/create_sqlazure_user.sql -v SqlUserName=$SQL_AZURE_USER_NAME

az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET -t $ARM_TENANT_ID
az account set --subscription $ARM_SUBSCRIPTION_ID

# echo 'Removing SQL Azure Firewall Rule'
az sql server firewall-rule delete -n $SQL_AZURE_FIREWALL_RULE_NAME -g $RESOURCE_GROUP_NAME -s $SQL_AZURE_SERVER_NAME
az logout --username $ARM_CLIENT_ID
