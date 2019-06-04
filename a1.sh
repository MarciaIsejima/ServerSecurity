#!/bin/bash
 
#replaces column text that contains commas
sed 's/Fairs, Festivals, Museums/Fairs Festivals Museums/' 'report-gaming-grant-year-to-date.csv' > temp1.txt

#generate a temp file with the search results
grep "^.*,$1.*," temp1.txt > temp2.txt

awk -F',' '{print $6;}' temp2.txt > temp3.txt

#calculates the sum
sum=$(awk '{n += $1}; END{print n}' temp3.txt)

#echo "sum is: " $sum

#write html page
cat > test.html << HTMLTEMPLATE
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>WMDD4950 - Assignment 2</title>
</head>
<body>
	<h1>Gaming Grants Paid to Community Organizations</h1>
	<p>Search: `echo $1`</p>
	<p>Total: `echo $sum`</p>
</body>
</html>
HTMLTEMPLATE
