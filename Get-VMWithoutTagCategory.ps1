$Category = Get-TagCategory -Name 'Backup'

Get-VM | Where{!(Get-TagAssignment -Entity $_ -Category $Category)} | Select Name