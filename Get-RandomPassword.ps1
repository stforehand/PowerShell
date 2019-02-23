# Random Password Generator

$KeyLength = 12

[Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
Do {
   $Password = [System.Web.Security.Membership]::GeneratePassword($KeyLength,[Math]::Floor(($KeyLength/2)))
} Until ($Password -Match '\d')

Set-Clipboard -Value $Password
Write-Host ""
Write-Host "The password has been copied to the clipboard."
Write-Host $Password -ForegroundColor Gray