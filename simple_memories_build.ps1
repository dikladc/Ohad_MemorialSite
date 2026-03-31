# Simple approach: read both files as UTF-8 and combine

# Read the working template
$template = [System.IO.File]::ReadAllText("Memories_new.html", [System.Text.Encoding]::UTF8)

# Read the UTF-8 converted memories content
$memContent = [System.IO.File]::ReadAllText("memories_text_utf8.htm", [System.Text.Encoding]::UTF8)

# Find the content section - look for the specific poem text to replace
$startPattern = 'אתר זה הוקם לזכרו'
$endPattern = 'תמיד יחכו לך / לאה שבת'

$startIdx = $template.IndexOf($startPattern)
$endIdx = $template.IndexOf($endPattern, $startIdx)

if ($startIdx -gt 0 -and $endIdx -gt $startIdx) {
    # Find the end of that line
    $endIdx = $template.IndexOf('</center>', $endIdx) + '</center>'.Length

    # Extract before and after
    $before = $template.Substring(0, $startIdx)
    $after = $template.Substring($endIdx)

    # Combine
    $result = $before + $memContent + "`r`n`r`n<center><br><br>`r`n<font size=`"4`"><a href='NewMemories.html'><b>להעלאת זכרון חדש, לחץ כאן</b></a></font>`r`n<br><br></center>`r`n" + $after

    # Update title in result
    $result = $result -replace '<TITLE>אוהד דותן - אתר הנצחה - תמיד יחכו לך</TITLE>', '<TITLE>אוהד דותן - אתר הנצחה - זכרונות</TITLE>'

    # Write without BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText("Memories.html", $result, $utf8NoBom)

    Write-Host "Created Memories.html successfully"
} else {
    Write-Host "Could not find content markers"
}
