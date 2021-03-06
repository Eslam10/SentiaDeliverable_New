function Create_VNwk_Subnets
{
	echo "############################################Create Virtual Network/Subnets############################################"
	echo "############################################Create Virtual Network/Subnets############################################" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt
	$VNWKExist = Get-AzureRmResource -ResourceName $FileLocations['VNKName'] -ResourceGroupName $RG_Name;
	if(!$VNWKExist)
	{
		New-AzureRmResourceGroupDeployment -ResourceGroupName $RG_Name `
		-TemplateUri $FileLocations['VNwktemplate'] -TemplateParameterUri $FileLocations['VNwkparameter'] >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
		if($? -eq "True")
		{
			echo "Virtual Network "$FileLocations['VNKName']" successfully created" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
		}
		else
		{
			echo "Virtual Network deployment failed" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
		}	
	}
	else
	{
		echo "Vitrual Network "$FileLocations['VNKName']" already exists" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt; 
	}
}