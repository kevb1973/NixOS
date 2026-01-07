#!/usr/bin/env bash
yad \
  --title='TV REMOTE' \
  --button='Power ON:bash -c "lgtv wakeonlan"' \
  --button='Power OFF:bash -c "lgtv system turnOff"' \
  --button='Mute ON:bash -c "lgtv audio setMute true"' \
  --button='Mute OFF:bash -c "lgtv audio setMute false"' \
  --button='Vol+:bash -c "lgtv audio volumeUp"' \
  --button='Vol-:bash -c "lgtv audio volumeDown"' \
  --button='Exit' \
  --on-top \
  --buttons-layout='center' \
  --center
