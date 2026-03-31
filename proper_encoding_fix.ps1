# Properly convert Hebrew HTML files from windows-1255 to UTF-8

$hebrewFiles = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html" |
    Where-Object { $_.Name -notmatch '^English' }

$count = 0
$encoding1255 = [System.Text.Encoding]::GetEncoding(1255)
$utf8WithBom = [System.Text.UTF8Encoding]::new($true)

foreach ($file in $hebrewFiles) {
    Write-Host "Converting: $($file.Name)"

    try {
        # Read file as windows-1255
        $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
        $text = $encoding1255.GetString($bytes)

        # Write as UTF-8 with BOM
        $utf8Bytes = $utf8WithBom.GetBytes($text)
        [System.IO.File]::WriteAllBytes($file.FullName, $utf8Bytes)

        $count++
        Write-Host "  Converted successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "  ERROR: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Converted $count files from windows-1255 to UTF-8 with BOM"
Write-Host "The UTF-8 BOM helps browsers detect the encoding correctly"
