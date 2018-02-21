CARD=`pacmd list-cards | grep -A10 -B20 "active profile: <headset_head_unit>" | grep name: | awk -F'[<|>]' '{ print $2 }'`
qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

if [ $CARD ];then
  echo "switching $CARD to A2DP"
  pacmd set-card-profile $CARD a2dp_sink
else
  CARD=`pacmd list-cards | grep -A10 -B20 "active profile: <a2dp_sink>" | grep name: | awk -F'[<|>]' '{ print $2 }'`
  if [ $CARD ];then
    echo "switching $CARD to Headset_Head_Unit"
    pacmd set-card-profile $CARD headset_head_unit
  fi
fi
