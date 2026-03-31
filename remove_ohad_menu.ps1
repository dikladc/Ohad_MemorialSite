# Remove the Ohad.html menu item from all HTML files

$files = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html"
$count = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false

    # Pattern to match the Ohad.html menu item (3 lines)
    # Looking for the TR block with Ohad.html link
    $pattern = '(?s)<TR>\s*<TD>\s*<a href="Ohad\.html"[^>]*>.*?</a></TD>\s*</TR>\s*'

    if ($content -match $pattern) {
        $content = $content -replace $pattern, ''
        $modified = $true
    }

    if ($modified) {
        # Preserve encoding based on file type
        if ($file.Name -match '^English') {
            $encoding = New-Object System.Text.UTF8Encoding $false
        } else {
            $encoding = New-Object System.Text.UTF8Encoding $false
        }

        [System.IO.File]::WriteAllText($file.FullName, $content, $encoding)
        Write-Host "Updated: $($file.Name)"
        $count++
    }
}

Write-Host ""
Write-Host "Removed Ohad.html menu item from $count files"
