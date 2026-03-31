# Fix menu: restore Ohad.html and remove Boomerang

$files = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html"
$count = 0

$ohadMenuItem = @"
	<TR>
		  <TD> <a href="Ohad.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','images/Ohad_bouton-ROL_04.jpg',1)"><img src="images/Ohad_bouton_04.jpg" name="Image23" width="230" height="30" border="0"></a></TD>
	</TR>
"@

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false

    # Step 1: Remove Boomerang menu item
    $boomerangPattern = '(?s)\s*<TR>\s*<TD>\s*<a href="/boomerang/"[^>]*>.*?</a></TD>\s*</TR>\s*'
    if ($content -match $boomerangPattern) {
        $content = $content -replace $boomerangPattern, "`r`n"
        $modified = $true
    }

    # Step 2: Restore Ohad.html menu item after Always.html
    $alwaysPattern = '(<TR>\s*<TD>\s*<a href="Always\.html"[^>]*>.*?</a></TD>\s*</TR>)'
    if ($content -match $alwaysPattern) {
        $content = $content -replace $alwaysPattern, "`$1`r`n$ohadMenuItem"
        $modified = $true
    }

    if ($modified) {
        $encoding = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $encoding)
        Write-Host "Updated: $($file.Name)"
        $count++
    }
}

Write-Host ""
Write-Host "Fixed menu in $count files - restored Ohad.html and removed Boomerang"
