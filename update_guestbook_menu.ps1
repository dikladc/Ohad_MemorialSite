# Update menu to add Guestbook link (3rd from bottom)

$files = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html" -Exclude "English_OLD.html"
$count = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false

    # Find the duplicate Memories.html link (button 13, third from bottom) and replace with Guestbook.html
    # This is the line with Image32 that currently points to Memories.html
    $pattern = '(<TD>\s*<a href=")Memories\.html(" onMouseOut="MM_swapImgRestore\(\)" onMouseOver="MM_swapImage\(''Image32'')'

    if ($content -match $pattern) {
        $content = $content -replace $pattern, '${1}Guestbook.html${2}'
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
Write-Host "Updated menu in $count files - Guestbook link added to menu"
