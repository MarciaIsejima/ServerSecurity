#!/bin/bash
 
#replaces column text that contains commas
sed 's/Fairs, Festivals, Museums/Fairs Festivals Museums/' 'report-gaming-grant-year-to-date.csv' > temp1.txt

#generate a temp file with the search results
grep "^.*,$1.*," temp1.txt > temp2.txt

awk -F',' '{print $6;}' temp2.txt > temp3.txt

#calculates the sum
sum=$(awk '{n += $1}; END{print n}' temp3.txt)

#echo "sum is: " $sum

#write html page with search results

cat > test.html << HTMLHEADER
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>WMDD4950 - Assignment 2</title>
	<style type=text/css>
		body {font-family: Arial; background-color: aliceblue}
		h1 {font-family: 'Lucida Sans', sans-serif; font-size: 2em; text-align: center}
		h2 {font-family: 'Lucida Sans', sans-serif; font-size: 1.5em; text-align: center}
		p {font-size: 1em}
	</style>
</head>
<body>
	<header style="padding: 15px;">
		<h1>Gaming Grants Paid to Community Organizations</h1>
		<h2>Search: `echo $1`</h2>
		<h2>Total: `echo $sum`</h2>
	</header>
	<div style="padding: 10px; display: flex; flex-flow: wrap; justify-content: space-around; border-radius: 5px; background-color: cadetblue">
HTMLHEADER

IFS=','
while read -r city organization type sector subsector amount;
do
	printf "	<div style=\"max-width: 300px; margin: 10px; padding: 15px; border-radius: 5px; background-color: aliceblue\">\n" >> test.html
	printf "		<p><b>City:</b> %s </p>\n " $city >> test.html
	printf "		<p><b>Organization:</b> %s </p>\n " $organization >> test.html
	printf "		<p><b>Grant Type:</b> %s </p>\n " $type >> test.html
	printf "		<p><b>Grant Sector:</b> %s </p>\n " $sector >> test.html
	printf "		<p><b>Grant Subsector:</b> %s </p>\n " $subsector >> test.html
	printf "		<p><b>Payment Amount:</b> $ %s </p>\n " $amount >> test.html
	printf "	</div>\n" >> test.html
done < temp2.txt;

cat << HTMLRESULT >>test.html


	</div>
</body>
</html>
HTMLRESULT
