###################################################################################
# Author: Eslam Mahmoud
# Contact: eslamsayedattiama@gmail.com
# Creation date: September 2018
# Version 0.2
# Description: Script for Sentia company assessment
###################################################################################

$DATE=Get-Date -UFormat "%d%m%Y_%H%M"

#Create new temp dir for script/modules/logs
New-Item -ItemType directory -Path C:\tempdir_$DATE
New-Item -ItemType directory -Path C:\tempdir_$DATE\Modules #Modules dir
New-Item -ItemType directory -Path C:\tempdir_$DATE\Logs	#Logs dir

#Check if there is a log file, to be removed
if (Test-Path C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt) 
{
  Remove-Item C:\tempdir_$DATE\Logs\AzureLog_$DATE.txt; #Start empty log file if exist
}


(Invoke-WebRequest https://raw.githubusercontent.com/Eslam10/SentiaDeliverable_New/master/Scripts/Modules/Get_Temp_Param_Files.psm1).Content > "C:\tempdir_$DATE\Modules\Get_Temp_Param_Files.psm1"
(Invoke-WebRequest https://raw.githubusercontent.com/Eslam10/SentiaDeliverable_New/master/Scripts/Modules/Create_Resource_Group.psm1).Content > "C:\tempdir_$DATE\Modules\Create_Resource_Group.psm1"
(Invoke-WebRequest https://raw.githubusercontent.com/Eslam10/SentiaDeliverable_New/master/Scripts/Modules/Create_Storage_Account.psm1).Content > "C:\tempdir_$DATE\Modules\Create_Storage_Account.psm1"
(Invoke-WebRequest https://raw.githubusercontent.com/Eslam10/SentiaDeliverable_New/master/Scripts/Modules/Create_VNwk_Subnets.psm1).Content > "C:\tempdir_$DATE\Modules\Create_VNwk_Subnets.psm1"
(Invoke-WebRequest https://raw.githubusercontent.com/Eslam10/SentiaDeliverable_New/master/Scripts/Modules/Create_Policy_Definition.psm1).Content > "C:\tempdir_$DATE\Modules\Create_Policy_Definition.psm1"
(Invoke-WebRequest https://raw.githubusercontent.com/Eslam10/SentiaDeliverable_New/master/Scripts/Modules/Create_Policy_Assignment.psm1).Content > "C:\tempdir_$DATE\Modules\Create_Policy_Assignment.psm1"

Import-Module "C:\tempdir_$DATE\Modules\Get_Temp_Param_Files.psm1" -Force;
Import-Module "C:\tempdir_$DATE\Modules\Create_Resource_Group.psm1" -Force;
Import-Module "C:\tempdir_$DATE\Modules\Create_Storage_Account.psm1" -Force;
Import-Module "C:\tempdir_$DATE\Modules\Create_VNwk_Subnets.psm1" -Force;
Import-Module "C:\tempdir_$DATE\Modules\Create_Policy_Definition.psm1" -Force;
Import-Module "C:\tempdir_$DATE\Modules\Create_Policy_Assignment.psm1" -Force;


$tmp = Get_Temp_Param_Files; #Return filelocations data to be used in all other modules.
$FileLocations = $tmp['1']; 
$RG_Name = Create_Resource_Group -FileLocations $FileLocations;  #Create RG, Return RG_Name
Create_Storage_Account -FileLocations $FileLocations -RG_Name $RG_Name;

Create_VNwk_Subnets -FileLocations $FileLocations -RG_Name $RG_Name;

$Resp_PD_id = Create_Policy_Definition -FileLocations $FileLocations; #Create Policy Def, Return Policy Definition ID

Create_Policy_Assignment -FileLocations $FileLocations -Resp_PD_id $Resp_PD_id -RG_Name $RG_Name;