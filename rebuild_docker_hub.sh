#!/bin/bash
# Copyright 2017, Florent Thiery
echo `date` > last_build
git add last_build
git commit -m "Update last build timestamp"
git push
