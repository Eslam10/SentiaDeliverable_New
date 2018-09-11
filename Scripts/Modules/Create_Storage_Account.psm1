function Create_Storage_Account
{
	echo "############################################Create Storage Account############################################"
	echo "############################################Create Storage Account############################################" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
	New-AzureRmResourceGroupDeployment -ResourceGroupName $RG_Name `
	-TemplateUri $FileLocations['SAtemplate'] `
	-TemplateParameterUri $FileLocations['SAparameters'] >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
	if($? -eq "True")
	{
		echo "Storage Account successfully created" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
	}
	else
	{
		echo "Storage Account deployment failed" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
	}	
}