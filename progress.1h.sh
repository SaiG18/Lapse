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
empty_char=""

bitbar="size=14 color=white font='Avenir'"

now=$(date +%s)

#Year
Y_start=$(date -j 01010000 +%s)
Y_end=$(date -jr "$Y_start" -v +1y +%s)
Y_progress=$(
echo "($now - $Y_start) * 100 / ($Y_end - $Y_start)" | bc -l
)

#Month
m_start=$(date -j "$(date +%m)010000" +%s)
m_end=$(date -jr "$m_start" -v +1m +%s)
m_progress=$(
echo "($now - $m_start) * 100 / ($m_end - $m_start)" | bc -l
)

#Day
d_start=$(date -j "$(date +%m%d)0000" +%s)
d_end=$(date -jr "$d_start" -v +1d +%s)
d_progress=$(
echo "($now - $d_start) * 100 / ($d_end - $d_start)" | bc -l
)

#Week
week_start=$(date +%u)
w_progress=$(
echo "($week_start) * 100 / (7)" | bc -l
)

#Life
#Assuming Birth Year is 2000
l_start=$(date +%u)
l_progress=$(
echo "($week_start) * 100 / (7)" | bc -l
)

round() { printf %.0f "$1"; }

progress() {
filled=$(round "$(echo "$1 * $width / 100" | bc -l)")
empty=$((width - filled))
# repeat the characters using printf
printf "$fill_char%0.s" $(seq "$filled")
printf "$empty_char%0.s" $(seq "$empty")
}

echo "Day: $(round "$d_progress")%"
echo ---

# day + progress bar
echo "Day: $(round "$d_progress")%   | $bitbar"
echo "$(progress "$d_progress")      | $bitbar"

# month + progress bar
echo " | $bitbar"
echo "Week: $(round "$w_progress")%   | $bitbar"
echo "$(progress "$w_progress")        | $bitbar"

# month + progress bar
echo " | $bitbar"
echo "Month: $(round "$m_progress")%   | $bitbar"
echo "$(progress "$m_progress")        | $bitbar"

# year + progress bar
echo " | $bitbar"
echo "Year: $(round "$Y_progress")%   | $bitbar"
echo "$(progress "$Y_progress")       | $bitbar"

# life + progress bar
echo " | $bitbar"
echo "Life: $(round "$l_progress")%   | $bitbar"
echo "$(progress "$l_progress")       | $bitbar"
