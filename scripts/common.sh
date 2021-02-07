#!/bin/bash
#
# Purpose: Common code that is likely loaded in most of the scripts
#          within this framework. Handles things such as a start date/time,
#          logging, and other various "common" functionality.

. "$HOME/.noaa-v2.conf"

# binary helpers
CONVERT="/usr/bin/convert"
MEDET_ARM="/usr/bin/medet_arm"
METEOR_DEMOD="/usr/bin/meteor_demod"
PREDICT="/usr/bin/predict"
RTL_FM="/usr/local/bin/rtl_fm"
SOX="/usr/bin/sox"
SQLITE3="/usr/bin/sqlite3"
WXMAP="/usr/local/bin/wxmap"
WXTOIMG="/usr/local/bin/wxtoimg"

# frequency ranges for objects
METEOR_FREQ="137.1000"
NOAA15_FREQ="137.6200"
NOAA18_FREQ="137.9125"
NOAA19_FREQ="137.1000"

declare -A levels=([DEBUG]=0 [INFO]=1 [WARN]=2 [ERROR]=3)
log_level=${LOG_LEVEL}

# log function
log() {
  local log_message=$1
  local log_priority=$2

  # check if level exists and is of the right level to log
  [[ ${levels[$log_priority]} ]] || return 1
  (( ${levels[$log_priority]} < ${levels[$log_level]} )) && return 2

  # log in place (which for at jobs end up in the linux mail)
  echo "${log_priority} : ${log_message}"

  # TODO: log to log file to help with processing outputs (Issue #27)
}

# current date and time
START_DATE=$(date '+%d-%m-%Y %H:%M')
