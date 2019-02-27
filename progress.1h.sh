#!/usr/bin/env bash

# Progress Bar of Day, Week, Month, Year, and Life
#
# by Sai G (http://github.com/SaiG18)
#
# <bitbar.title>Lapse</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>SaiG18</bitbar.author>
# <bitbar.author.github>SaiG18</bitbar.author.github>
# <bitbar.desc>Progress Bar of Day, Week, Month, Year, and Life.</bitbar.desc>
# <bitbar.dependencies>bash</bitbar.dependencies>


width=20
fill_char="▄"
empty_char="__"

bitbar="size=15 color=white font='Avenir'"

now=$(date +%s)

#Year
yearStart=$(date -j 01010000 +%s)
yearEnd=$(date -jr "$yearStart" -v +1y +%s)
yearProgress=$(
echo "($now - $yearStart) * 100 / ($yearEnd - $yearStart)" | bc -l
)

#Month
monthStart=$(date -j "$(date +%m)010000" +%s)
monthEnd=$(date -jr "$monthStart" -v +1m +%s)
monthProgress=$(
echo "($now - $monthStart) * 100 / ($monthEnd - $monthStart)" | bc -l
)

#Day
dayStart=$(date -j "$(date +%m%d)0000" +%s)
dayEnd=$(date -jr "$dayStart" -v +1d +%s)
dayProgress=$(
echo "($now - $dayStart) * 100 / ($dayEnd - $dayStart)" | bc -l
)

#Week
week_start=$(date +%u)
weekProgress=$(
echo "($week_start) * 100 / (7)" | bc -l
)

#Life
#Assuming Birth Year is 2000
presentYear=$(date +%Y-2001)
presentMonth=$(date +%m/12)
l_expected=80
lifeProgress=$(
echo "( $presentYear + $presentMonth) * 100 /($l_expected)" | bc -l
)

round() { printf %.0f "$1"; }

progress() {
filled=$(round "$(echo "$1 * $width / 100" | bc -l)")
empty=$((width - filled))
# repeat the characters using printf
printf "$fill_char%0.s" $(seq "$filled")
printf "$empty_char%0.s" $(seq "$empty")
}

echo "Day: $(round "$dayProgress")%"
echo ---

# day + progress bar
echo "Day: $(round "$dayProgress")%   | $bitbar"
echo "$(progress "$dayProgress")      | $bitbar"

# week + progress bar
echo " | $bitbar"
echo "Week: $(round "$weekProgress")%   | $bitbar"
echo "$(progress "$weekProgress")        | $bitbar"

# month + progress bar
echo " | $bitbar"
echo "Month: $(round "$monthProgress")%   | $bitbar"
echo "$(progress "$monthProgress")        | $bitbar"

# year + progress bar
echo " | $bitbar"
echo "Year: $(round "$yearProgress")%   | $bitbar"
echo "$(progress "$yearProgress")       | $bitbar"

# life + progress bar
echo " | $bitbar"
echo "Life: $(round "$lifeProgress")%   | $bitbar"
echo "$(progress "$lifeProgress")       | $bitbar"
