;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; !HOSTS COMMAND ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This script relies on sections of ankhbot.mrc, otherwise you will have to edit the script to work properly without it.

ON *:TEXT:!hosts:%mychan: {
  IF ($nick isop $chan) {
    JSONOpen -uw gethosts http://tmi.twitch.tv/hosts?include_logins=1&target= $+ %TwitchID $+ &nocache= $+ $ticks
    JSONUrlHeader gethosts Client-ID avm4vi7zv0xpjkpi3d4x0qzk8xbrdw8
    JSONUrlGet gethosts
    VAR %x = 0 | WHILE ($json(gethosts, hosts, %x, host_login) != $null) {
      VAR %hosts %hosts $cached_name($json(gethosts, hosts, %x, host_login)) $+ $chr(44)
      INC %x
    }
    IF (%hosts != $null) MSG $chan bleedPurple Thank You to all these $numtok(%hosts, 32) awesome people who are currently hosting this stream:  $left($sorttok(%hosts , 32, a), -1)  bleedPurple
    ELSE MSG $chan $nick $+ , no one is hosting the channel at the moment.  FeelsBadMan
    JSONClose gethosts
    HSAVE -o displaynames displaynames.htb
  }
}

