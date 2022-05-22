#include <sourcemod>
#include <sdktools>
#include <cstrike>


public Plugin:myinfo =
{
  name = "music on round start/end",
  author = "conner",
  description = "Play soundbyte on start and end round",
  version = "38.2",
};

public void OnPluginStart()
{
  HookEvent("round_end", Event_RoundEnd, EventHookMode_Post);
  HookEvent("round_start", Event_RoundStart, EventHookMode_Post);
}

public Action Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
  int fg_track_int = GetRandomInt(1, 19);
  char fg_track[1024];
  char fg_track_num[1024];
  IntToString(fg_track_int, fg_track_num, sizeof(fg_track_num));
  Format(fg_track, sizeof(fg_track), "fg%s.mp3", fg_track_num);
  PrecacheSound(fg_track);
  EmitSoundToAll(fg_track);
  return Plugin_Continue;
}
public Action Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
  PrecacheSound("curb.mp3");
  EmitSoundToAll("curb.mp3");
  return Plugin_Continue;
}
