#!/bin/bash

OUTPUT_FILE="index.html"

echo "<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>mvn.wesjd.net</title>
<style>
body { font-family: sans-serif; padding: 2rem; }
h1 { color: #333; }
ul { line-height: 1.6; }
a { text-decoration: none; color: #0366d6; }
</style>
</head>
<body>
<h1>mvn.wesjd.net</h1>
<p>Contents:</p>
<ul>" > "$OUTPUT_FILE"

find . -type d ! -path . | sort | while read dir; do
    # Skip hidden directories
    [[ "$(basename "$dir")" == .* ]] && continue
    # Skip CNAME and the script itself if listed
    [[ "$(basename "$dir")" == "CNAME" ]] && continue
    [[ "$(basename "$dir")" == "$(basename "$0")" ]] && continue
    # Generate link relative to root
    href="${dir#./}/"
    echo "  <li><a href=\"$href\">$href</a></li>" >> "$OUTPUT_FILE"
done

echo "</ul>
</body>
</html>" >> "$OUTPUT_FILE"

echo "index.html generated successfully."

