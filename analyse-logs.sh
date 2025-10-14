#!/bin/bash

LOG_DIR="/home/loai/logs"
ERROR_PATTERNS=("Thread" "INFO" "DEBUG" "Kernel")
REPORT_FILE="/home/loai/logs/log_analysis_report.txt"

echo "analyzing log files" > "$REPORT_FILE"
echo "====================" >> "$REPORT_FILE"

echo -e "\nlist of files update in last 24 hours" >> "$REPORT_FILE"
LOG_FILES=$(find $LOG_DIR -name "*.log" -mtime -1)
echo $LOG_FILES >> "$REPORT_FILE"

for LOG_FILES in $LOG_FILES; do

   for PATTERN in ${ERROR_PATTERNS[@]}; do

   echo -e "\n" >> "$REPORT_FILE"
   echo "=========================================" >> "$REPORT_FILE"
   echo "=========$LOG_FILES======" >> "$REPORT_FILE"
   echo "=========================================" >> "$REPORT_FILE"

echo -e "\nlist of $PATTERN logs in $LOG_FILES" >> "$REPORT_FILE"
grep "$PATTERN" "$LOG_FILES" >> "$REPORT_FILE"

echo -e "\nNumber of $PATTERN logs in $LOG_FILES" >> "$REPORT_FILE"

ERROR_COUNT=$(grep -c "$PATTERN" "$LOG_FILES" )
 echo ERROR_COUNT >> "$REPORT_FILE"
 if [ "$ERROR_COUNT" -eq 30 ]; then
   echo -e "\nAction Required: too many $PATTERN issue in log $LOG_FILES"
   fi

  done
done
echo -e "\nLog analysis completed and report saved in: $REPORT_FILE"