# Update all Memories.php and Guestbook.php links to point to Memories.html

$files = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html"
$count = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false

    # Replace Memories.php with Memories.html
    if ($content -match 'NewMemories\.html') {
        # Change NewMemories.html back to Memories.html in navigation
        $content = $content -replace 'href=[''"]NewMemories\.html[''"]', 'href="Memories.html"'
        $modified = $true
    }

    if ($modified) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Host "Updated: $($file.Name)"
        $count++
    }
}

Write-Host ""
Write-Host "Updated $count files - navigation links now point to Memories.html"
