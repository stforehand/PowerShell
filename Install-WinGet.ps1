# Get the latest download URL for WinGet
$URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$URL = (Invoke-WebRequest -Uri $URL).Content | ConvertFrom-Json |
        Select-Object -ExpandProperty "assets" |
        Where-Object "browser_download_url" -Match '.msixbundle' |
        Select-Object -ExpandProperty "browser_download_url"
$LicenseFileURL = 'https://github.com/microsoft/winget-cli/releases/download/v1.7.2782-preview/f1c7c505b9934655be2195c074913cbf_License1.xml'

# Download WinGet
Invoke-WebRequest -Uri $URL -OutFile "C:\Temp\Setup.msix" -UseBasicParsing
Invoke-WebRequest -Uri $LicenseFileURL -OutFile  'C:\Temp\license.xml' 

# Install WinGet
# Add-AppxPackage -Path "Setup.msix" -LicensePath .\license.xml
Add-AppxProvisionedPackage -PackagePath "C:\Temp\Setup.msix" -LicensePath 'C:\Temp\license.xml' -online 

# Clean up
Remove-Item "C:\Temp\Setup.msix"
