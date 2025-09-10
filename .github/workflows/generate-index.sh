#!/bin/bash
# generate-index.sh

cat <<EOF > repo/index.html
<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Helm Chart Repo</title></head>
<body><h1>Available Charts</h1><ul>
EOF

grep 'name: tlaokas' -A 3 repo/index.yaml | grep version | awk '{ print $2 }' | while read version; do
  echo "<li><a href=\"tlaokas-$version.tgz\">tlaokas-$version.tgz</a></li>" >> repo/index.html
done

cat <<EOF >> repo/index.html
</ul></body></html>
EOF