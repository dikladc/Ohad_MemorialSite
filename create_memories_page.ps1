# Create Memories.html from template and content

# Read the template (Always.html structure)
$template = Get-Content "C:\Users\dikladc\Downloads\OhadSite-New\Always.html" -Raw -Encoding UTF8

# Read the memories content
$encoding1255 = [System.Text.Encoding]::GetEncoding(1255)
$memoriesBytes = [System.IO.File]::ReadAllBytes("C:\Users\dikladc\Downloads\OhadSite\memories_text.htm")
$memoriesContent = $encoding1255.GetString($memoriesBytes)

# Split template into header and footer
$headerEnd = $template.IndexOf('<font class="c">')
$footerStart = $template.IndexOf('</font></div>')

if ($headerEnd -eq -1 -or $footerStart -eq -1) {
    Write-Host "Error: Could not find content markers"
    exit
}

$header = $template.Substring(0, $headerEnd + '<font class="c">'.Length)
$footer = $template.Substring($footerStart)

# Update title and meta tags in header
$header = $header -replace '<TITLE>.*?</TITLE>', '<TITLE>אוהד דותן - אתר הנצחה - זכרונות</TITLE>'
$header = $header -replace '<META Name ="description" CONTENT =".*?">', '<META Name ="description" CONTENT ="זכרונות על אוהד - משפחה וחברים חולקים זיכרונות, תמונות וחוויות עם אוהד אהובנו">'

# Add link to new memories form before the footer
$linkToNewMemories = "`r`n`r`n<center><br><br><a href='NewMemories.html'><b>להעלאת זכרון חדש, לחץ כאן</b></a><br><br></center>`r`n`r`n"

# Combine everything
$fullPage = $header + "`r`n" + $memoriesContent + $linkToNewMemories + $footer

# Write as UTF-8 with BOM
$utf8WithBom = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText("C:\Users\dikladc\Downloads\OhadSite-New\Memories.html", $fullPage, $utf8WithBom)

Write-Host "Created Memories.html with all memories content and proper UTF-8 encoding"
