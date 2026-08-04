#!/usr/bin/env zsh
local dir="${0:A:h}" f rc=0
for f in "$dir"/test_*.zsh; do
  print -r -- "== ${f:t} =="
  zsh "$f" || rc=1
done
(( rc == 0 )) && print -r -- "ALL GREEN" || print -r -u2 -- "SOME RED"
exit $rc
