Function Export-Tags {
    # Import vCenter Tags and Categories

    ForEach($Tag in Import-Csv C:\vCenter-Tags.csv -UseCulture){

        Try{

            Get-TagCategory -Name $Tag.Category -ErrorAction Stop

        }

        Catch{

            New-TagCategory -Name $Tag.Category -Description $Tag.cDescription -Cardinality $Tag.Cardinality -Confirm:$false

        }

        If($Tag.Name){

            Try{

                Get-Tag -Category $Tag.Category -Name $Tag.Name -ErrorAction Stop

            }

            Catch{

                New-Tag -Name $Tag.Name -Category $Tag.Category -Description $Tag.Description -Confirm:$False

            }

        }

    }
}

Function Export-Tags {
    # Export vCenter Tags and Categories

    &{ForEach($Category in Get-TagCategory){

        $Tags = Get-Tag -Category $Category

        If($Tags){

            $Tags | Select @{N='Category';E={$Category.Name}},@{N='cDescription';E={$Category.Description}},@{N='Cardinality';E={$Category.Cardinality}},Name,Description

        }

        Else{

            $Category | Select @{N='Category';E={$Category.Name}},@{N='cDescription';E={$Category.Description}},@{N='Cardinality';E={$Category.Cardinality}},@{N='Name';E={''}},@{N='Description';E={''}}

        }

    }} | Export-Csv C:\vCenter-Tags.csv -NoTypeInformation -UseCulture
