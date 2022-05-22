#include <sourcemod>
#include <sdktools>
#include <sdktools_sound>

public Plugin:myinfo =
{
  name =  "Decoy bomb planting",
  author = "conner",
  description = "replace decoy sounds",
  version = "1.0",
};

int decoy;

public void OnPluginStart()
{
  HookEvent("decoy_started", Event_decoystarted, EventHookMode_Pre);
  HookEvent("decoy_firing", Event_firing, EventHookMode_Pre);
  AddNormalSoundHook(SoundHook);
}
public Action Event_firing(Event event, const char[] name, bool dontBroadcast)
{
  return Plugin_Continue;
}
public Action Event_decoystarted(Event event, const char[] name, bool dontBroadcast)
{
  int user = event.GetInt("userid");
  decoy = event.GetInt("entityid");
  float position[3];
  position[0] = event.GetFloat("x");
  position[1] = event.GetFloat("y");
  position[2] = event.GetFloat("z");
  int userid = GetClientOfUserId(user)

  // use your own sound files and store in csgo/sound/. must be mp3s
  if (GetClientTeam(userid) == 2)
  {
    PrecacheSound("decoy.mp3");
    EmitAmbientSound("decoy.mp3", position, decoy, 100);
  }
  else
  {
    PrecacheSound("defuse.mp3");
    EmitAmbientSound("defuse.mp3", position, decoy, 100);
  }
  return Plugin_Continue;
}

public Action SoundHook(clients[64], &numClients, char sound[PLATFORM_MAX_PATH], &entity, &channel, &Float:volume, &level, &pitch, &flags)
{
    if (entity == decoy && entity > 0)
    {
      volume = 0;
      return Plugin_Changed;
    }
    if (StrContains(sound, "flashbang/grenade_hit1") > -1)
    {
      volume = 0;
      return Plugin_Changed;
    }
    return Plugin_Continue;
}
