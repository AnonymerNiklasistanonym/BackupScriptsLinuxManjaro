#!/usr/bin/env bash



echo -n "Get list of all manually installed packages of Pacman and their version..."

# -------TIME-TRACKING-----------------
start_ms=`date +%s%3N`
# -------TIME-TRACKING-----------------

echo "Program,Version" > installed_programs.csv
# pacman [Arch Linux package manager utility.]
# Command: "-Q"/"--query":    Query the package database
# Option:  "-e"/"--explicit": Restrict or filter output to explicitly installed packages
# -------------------------------------------------------------------------------------------
# tr [Translate characters: run replacements based on single characters and character sets.]
# "tr A B" replaces all occurrences of string A to B and prints the result
pacman -Qe | tr " " "," >> installed_programs.csv

# -------TIME-TRACKING-----------------
end_ms=`date +%s%3N`
echo " $((end_ms - start_ms))ms"
# -------TIME-TRACKING----------------



echo -n "Get list of all manually installed packages of Pacman and more info..."

# -------TIME-TRACKING-----------------
start_ms=`date +%s%3N`
start_s=`date +%s`
# -------TIME-TRACKING-----------------

echo "Program,Version,Date,Size,Description" > installed_programs_detailed_fast.csv
# pacman [Arch Linux package manager utility.]
# Command: "-Q"/"--query":    Query the package database
# Option:  "-e"/"--explicit": Restrict or filter output to explicitly installed packages
# Option:  "-i"/"--info":     Display information on a given package
# -------------------------------------------------------------------------------------------
# grep [Matches patterns in input text.]
# "echo MULTILINE_STRING | grep KEYWORD" returns the line that contains the keyword
# -------------------------------------------------------------------------------------------
# cut [Cut out fields from `stdin` or files.]
# "echo STRING | cut -d':' -f2-" splits the string at all ':' and returns all parts
# beginning at the seond part
# -------------------------------------------------------------------------------------------
# awk [A versatile programming language for working on files. ]
# "echo STRING | awk '{$1=$1};1'" removes trailing whitespaces
pacman -Qei | while read LINE; do
    # If line is empty analyze the collected multiline string
    if [[ -z $LINE ]]; then
        NAME=$(        echo -e "$DATA" | grep 'Name'           | cut -d':' -f2- | awk '{$1=$1};1' )
        VERSION=$(     echo -e "$DATA" | grep 'Version'        | cut -d':' -f2- | awk '{$1=$1};1' )
        SIZE=$(        echo -e "$DATA" | grep 'Installed Size' | cut -d':' -f2- | awk '{$1=$1};1' )
        DATE=$(        echo -e "$DATA" | grep 'Install Date'   | cut -d':' -f2- | awk '{$1=$1};1' )
        DESCRIPTION=$( echo -e "$DATA" | grep 'Description'    | cut -d':' -f2- | awk '{$1=$1};1' )
        echo "$NAME,$VERSION,$DATE,\"$SIZE\",\"$DESCRIPTION\"" >> installed_programs_detailed_fast.csv
        DATA=""
    else
        # As long as the line is not empty concatenate the lines while preserving newlines
        DATA="${DATA}\n${LINE}"
    fi
done

# -------TIME-TRACKING-----------------
end_ms=`date +%s%3N`
end_s=`date +%s`
echo -n " $((end_ms - start_ms))ms / "
echo "$((end_s - start_s))s"
# -------TIME-TRACKING----------------
