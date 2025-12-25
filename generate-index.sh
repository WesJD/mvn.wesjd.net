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
<p>Contents</p>
<ul>" > "$OUTPUT_FILE"

find . -type f | sort | while read file; do
    # Skip files in dot directories
    if [[ "$file" =~ (^|/)\.[^/]+ ]]; then
        continue
    fi
    # Skip CNAME, index.html, and the script itself
    base=$(basename "$file")
    if [[ "$base" == "CNAME" ]] || [[ "$base" == "$(basename "$0")" ]] || [[ "$base" == "index.html" ]]; then
        continue
    fi
    href="${file#./}"
    echo "  <li><a href=\"$href\">$href</a></li>" >> "$OUTPUT_FILE"
done

echo "</ul>
</body>
</html>" >> "$OUTPUT_FILE"

echo "index.html generated successfully."

