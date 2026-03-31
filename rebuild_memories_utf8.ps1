# Rebuild Memories.html with proper UTF-8 encoding

# Step 1: Read and convert memories content to UTF-8
$enc1255 = [System.Text.Encoding]::GetEncoding(1255)
$memBytes = [System.IO.File]::ReadAllBytes("C:\Users\dikladc\Downloads\OhadSite\memories_text.htm")
$memContent = $enc1255.GetString($memBytes)

# Step 2: Save converted content temporarily
$utf8 = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText("memories_content_utf8.tmp", $memContent, $utf8)

# Step 3: Read template (Always.html already in UTF-8)
$template = [System.IO.File]::ReadAllText("Always.html", [System.Text.Encoding]::UTF8)

# Step 4: Find content section
$startMarker = '<font class="c">'
$endMarker = '</font></div>'

$startIdx = $template.IndexOf($startMarker)
$endIdx = $template.IndexOf($endMarker, $startIdx)

if ($startIdx -gt 0 -and $endIdx -gt $startIdx) {
    # Extract template parts
    $before = $template.Substring(0, $startIdx + $startMarker.Length)
    $after = $template.Substring($endIdx)

    # Read converted memories content
    $memContentUtf8 = [System.IO.File]::ReadAllText("memories_content_utf8.tmp", [System.Text.Encoding]::UTF8)

    # Add link to new memories form
    $newMemLink = "`r`n`r`n<center><br><br>`r`n<font size=`"4`"><a href='NewMemories.html'><b>להעלאת זכרון חדש, לחץ כאן</b></a></font>`r`n<br><br></center>`r`n`r`n"

    # Combine all parts
    $final = $before + "`r`n" + $memContentUtf8 + $newMemLink + $after

    # Update title and meta tags
    $final = $final -replace '<TITLE>[^<]+</TITLE>', '<TITLE>אוהד דותן - אתר הנצחה - זכרונות</TITLE>'

    # Write final file as UTF-8 with BOM
    [System.IO.File]::WriteAllText("Memories.html", $final, $utf8)

    # Clean up temp file
    Remove-Item "memories_content_utf8.tmp"

    Write-Host "Successfully rebuilt Memories.html with proper UTF-8 encoding"
} else {
    Write-Host "Error: Could not find content markers in template"
}
