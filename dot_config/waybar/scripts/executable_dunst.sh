#!/bin/bash

COUNT=$(dunstctl count waiting)
ENABLED="<span color='#f9e2af'>󰂚</span>"
DISABLED="<span color='#f38ba8'>󱏧</span>"
if [ $COUNT != 0 ]; then DISABLED="$DISABLED $COUNT"; fi
if dunstctl is-paused | grep -q "false" ; then echo $ENABLED; else echo $DISABLED; fi
