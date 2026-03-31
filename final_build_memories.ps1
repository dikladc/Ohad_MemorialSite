# Final build of Memories.html using UTF-8 content

# Read template (Always.html - already UTF-8)
$template = [System.IO.File]::ReadAllText("Always.html", [System.Text.Encoding]::UTF8)

# Read memories content (now UTF-8)
$memContent = [System.IO.File]::ReadAllText("memories_text_utf8.htm", [System.Text.Encoding]::UTF8)

# Find content section markers
$startMarker = '<font class="c">'
$endMarker = '</font></div>'

$startIdx = $template.IndexOf($startMarker)
$endIdx = $template.IndexOf($endMarker, $startIdx)

if ($startIdx -gt 0 -and $endIdx -gt $startIdx) {
    # Extract template parts
    $before = $template.Substring(0, $startIdx + $startMarker.Length)
    $after = $template.Substring($endIdx)

    # Read the link HTML from a file
    $linkFile = "new_memory_link.html"
    if (Test-Path $linkFile) {
        $linkHtml = [System.IO.File]::ReadAllText($linkFile, [System.Text.Encoding]::UTF8)
    } else {
        $linkHtml = ""
    }

    # Combine
    $final = $before + [System.Environment]::NewLine + $memContent + $linkHtml + $after

    # Update title
    $final = $final -replace '<TITLE>.*?</TITLE>', '<TITLE>אוהד דותן - אתר הנצחה - זכרונות</TITLE>'

    # Write as UTF-8 with BOM
    $utf8 = [System.Text.UTF8Encoding]::new($true)
    [System.IO.File]::WriteAllText("Memories.html", $final, $utf8)

    Write-Host "Successfully created Memories.html with UTF-8 encoding"
} else {
    Write-Host "Error: Could not find markers"
}
