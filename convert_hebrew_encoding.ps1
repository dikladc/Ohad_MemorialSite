# Convert Hebrew HTML files from windows-1255 to UTF-8
# Excludes English pages which are already in UTF-8

$hebrewFiles = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html" | Where-Object { $_.Name -notmatch '^English' }

foreach ($file in $hebrewFiles) {
    Write-Host "Processing: $($file.Name)"

    try {
        # Read file as windows-1255 (code page 1255)
        $encoding1255 = [System.Text.Encoding]::GetEncoding(1255)
        $content = [System.IO.File]::ReadAllText($file.FullName, $encoding1255)

        # Write as UTF-8 without BOM (the charset meta tag is already UTF-8)
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)

        Write-Host "  Converted: $($file.Name)"
    }
    catch {
        Write-Host "  Error: $($file.Name) - $_"
    }
}

Write-Host ""
Write-Host "Done! Hebrew HTML files converted from windows-1255 to UTF-8"
Write-Host "English.html and English_OLD.html were skipped (already UTF-8)"
