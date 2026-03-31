# Fix Hebrew encoding - properly convert from windows-1255 to UTF-8

$files = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html"

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"

    # Read file as windows-1255 (code page 1255)
    $encoding1255 = [System.Text.Encoding]::GetEncoding(1255)
    $content = [System.IO.File]::ReadAllText($file.FullName, $encoding1255)

    # Ensure charset meta tag is UTF-8
    $content = $content -replace 'charset=windows-1255', 'charset=UTF-8'

    # Write as UTF-8 without BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)

    Write-Host "  Converted: $($file.Name)"
}

Write-Host "`nDone! All HTML files converted from windows-1255 to UTF-8"
