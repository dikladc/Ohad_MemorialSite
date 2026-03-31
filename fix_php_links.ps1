# Fix broken PHP links - replace with HTML pages

$files = Get-ChildItem "C:\Users\dikladc\Downloads\OhadSite-New\*.html"
$count = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false

    # Replace Memories.php with NewMemories.html
    if ($content -match 'Memories\.php') {
        $content = $content -replace 'Memories\.php', 'NewMemories.html'
        $modified = $true
    }

    # Replace Guestbook.php with NewMemories.html
    if ($content -match 'Guestbook\.php') {
        $content = $content -replace 'Guestbook\.php', 'NewMemories.html'
        $modified = $true
    }

    if ($modified) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Host "Fixed: $($file.Name)"
        $count++
    }
}

Write-Host ""
Write-Host "Fixed $count files - replaced .php links with .html pages"
