function Create_Resource_Group
{
	echo "############################################Create Resource Group############################################"
	echo "############################################Create Resource Group############################################" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
	$webRGParameters  = Invoke-WebRequest $FileLocations['RGParametersFileLocation']
	$webRGTag         = Invoke-WebRequest $FileLocations['RGTagFileLocation']
	$RGParameters     = ConvertFrom-StringData -StringData $webRGParameters.Content
	$RGTag            = ConvertFrom-StringData -StringData $webRGTag.Content
	$ResourceGroupExist = Get-AzureRmResourceGroup -Name $RGParameters['Name'] -ErrorAction SilentlyContinue
	if(!$ResourceGroupExist)
	{
		New-AzureRmResourceGroup @RGParameters -Tag $RGTag -Force >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
		if($? -eq "True")
		{
			echo "Resource Group $RGParameters['Name'] successfully created" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
		}
		else
		{
			echo "Resource Group deployment failed" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt;
		}	
		$RG_Name = $RGParameters['Name'];
	}
	else
	{
		echo "Resource Group [$RG_Name] already exists" >> C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt; 
	}
		return $RG_Name;
}