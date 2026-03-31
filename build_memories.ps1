# Build Memories.html page

# Step 1: Copy Always.html as template
Copy-Item "Always.html" "Memories_temp.html" -Force

# Step 2: Read as UTF-8
$content = [System.IO.File]::ReadAllText("Memories_temp.html", [System.Text.Encoding]::UTF8)

# Step 3: Read memories content as windows-1255 and convert to UTF-8
$enc1255 = [System.Text.Encoding]::GetEncoding(1255)
$memBytes = [System.IO.File]::ReadAllBytes("C:\Users\dikladc\Downloads\OhadSite\memories_text.htm")
$memContent = $enc1255.GetString($memBytes)

# Step 4: Find and replace the content section
# Find the start of content (after <font class="c">)
$startMarker = '<font class="c">'
$endMarker = '</font></div>'

$startIdx = $content.IndexOf($startMarker)
$endIdx = $content.IndexOf($endMarker, $startIdx)

if ($startIdx -gt 0 -and $endIdx -gt $startIdx) {
    $before = $content.Substring(0, $startIdx + $startMarker.Length)
    $after = $content.Substring($endIdx)

    # Combine
    $newContent = $before + [System.Environment]::NewLine + $memContent + [System.Environment]::NewLine + $after

    # Write output
    $utf8 = [System.Text.UTF8Encoding]::new($true)
    [System.IO.File]::WriteAllText("Memories.html", $newContent, $utf8)

    Write-Host "Successfully created Memories.html"
    Remove-Item "Memories_temp.html"
} else {
    Write-Host "Error: Could not find content markers"
}
