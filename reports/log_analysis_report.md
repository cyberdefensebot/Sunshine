# Log Analysis Report

## Scope
Analysis of the mock events in `logs/sys_events.log`.

## ERROR entries
The output of `grep "ERROR" logs/sys_events.log` is saved in `logs/error_report.txt`.

## Root and user01 references
Run `grep -E "root|user01" logs/sys_events.log` to view events mentioning either account.

## First and last records
Use `head -n 5 logs/sys_events.log` and `tail -n 5 logs/sys_events.log`.

## Findings
[After reviewing the output, summarize the mock events and any patterns. Do not describe mock events as real incidents.]
