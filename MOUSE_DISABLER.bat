cd\
cd %Userprofile%
powershell "Set-ExecutionPolicy Unrestricted"
powershell "Get-WmiObject win32_PointingDevice | Where-Object { $_.Description -match 'hid'} | Format-Table pnpDeviceID -AutoSize -Wrap" >pnpdevid.txt
type pnpdevid.txt | findstr "HID" >devid.txt
del pnpdevid.txt
echo $content = Get-Content -Path '%Userprofile%\devid.txt' >Dismouse.ps1
echo Disable-PnpDevice -InstanceId $content -confirm:$false >>Dismouse.ps1
echo $content = Get-Content -Path '%Userprofile%\devid.txt' >Enmouse.ps1
echo Enable-PnpDevice -InstanceId $content -confirm:$false >>Enmouse.ps1
powershell .\Dismouse.ps1
TIMEOUT /T 10
powershell .\Enmouse.ps1
del devid.txt
del Dismouse.ps1
del Enmouse.ps1