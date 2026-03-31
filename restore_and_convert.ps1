# Restore original Hebrew files and convert them to UTF-8

$sourceFolder = "C:\Users\dikladc\Downloads\OhadSite"
$targetFolder = "C:\Users\dikladc\Downloads\OhadSite-New"

# Get all HTML files except English ones
$hebrewFiles = Get-ChildItem "$sourceFolder\*.html" |
    Where-Object { $_.Name -notmatch '^English' }

Write-Host "Step 1: Copying original files..."
Write-Host ""

foreach ($file in $hebrewFiles) {
    Copy-Item -Path $file.FullName -Destination "$targetFolder\$($file.Name)" -Force
    Write-Host "  Copied: $($file.Name)"
}

Write-Host ""
Write-Host "Step 2: Converting from windows-1255 to UTF-8..."
Write-Host ""

$encoding1255 = [System.Text.Encoding]::GetEncoding(1255)
$utf8WithBom = [System.Text.UTF8Encoding]::new($true)
$count = 0

foreach ($file in $hebrewFiles) {
    $targetFile = "$targetFolder\$($file.Name)"

    try {
        # Read file as windows-1255
        $bytes = [System.IO.File]::ReadAllBytes($targetFile)
        $text = $encoding1255.GetString($bytes)

        # Update charset meta tag
        $text = $text -replace 'charset=windows-1255', 'charset=UTF-8'

        # Write as UTF-8 with BOM
        $utf8Bytes = $utf8WithBom.GetBytes($text)
        [System.IO.File]::WriteAllBytes($targetFile, $utf8Bytes)

        $count++
        Write-Host "  Converted: $($file.Name)"
    }
    catch {
        Write-Host "  ERROR: $($file.Name) - $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done! Copied and converted $count Hebrew files to UTF-8"
Write-Host "English.html was preserved (not overwritten)"
