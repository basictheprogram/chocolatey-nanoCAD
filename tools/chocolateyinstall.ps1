$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName    = 'nanoCAD'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation64 = 'N:\gold-images\nanoCAD\NCE50(2007).exe'                             # Change to your URI
$checkSum64     = 'ecbf276d405e36010db5840cddd3e1db3f7b2ccb3cc8ff620e7a2cb4a0344956'

$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$UnzipArgs = @{
   PackageName  = $packageName
   FileFullPath = $fileLocation64 
   Destination  = $WorkSpace
}

Get-ChocolateyUnzip @UnzipArgs

$InstallArgs = @{
   PackageName    = $packageName
   File           = Join-Path $WorkSpace "$packageName.msi"
   fileType       = 'msi'
   silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1 APIINSTALL=0 LICENSETYPE=0"
   validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @InstallArgs
