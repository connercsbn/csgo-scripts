#include <sourcemod>
#include <sdktools>
#include <sdktools_sound>

public Plugin:myinfo =
{
  name = "Event Hooks",
  author = "conner",
  description = "Various event hooks",
  version = "1.0",
};

char song[64];
int bombTime;

public void OnPluginStart()
{
  ConVar g_cvBombTime = FindConVar("mp_c4timer");
	SetConVarFlags(g_cvBombTime, GetConVarFlags(g_cvBombTime) & ~FCVAR_NOTIFY);
  HookEvent("round_start", OnRoundStart, EventHookMode_PostNoCopy);
  HookEvent("player_death", Event_PlayerDeath, EventHookMode_Post);
  HookEvent("bomb_planted", Event_BombPlant, EventHookMode_Post);
}
public OnRoundStart(Handle event, const char[] name, bool dontBroadcast)
{
  ConVar g_cvBombTime = FindConVar("mp_c4timer");
  int randomnum = GetRandomInt(0, 16);
  switch (randomnum)
  {
    case 0:
    {
      song = "clevelandthemelong.mp3";
      g_cvBombTime.SetInt(39, false, false);
    }
    case 1:
    {
      song = "rnrmcd.mp3";
      g_cvBombTime.SetInt(127, false, false);
    }
    case 2:
    {
      song = "oceanmanbomb.mp3";
      g_cvBombTime.SetInt(48, false, false);
    }
    case 3:
    {
      song = "roganbomb.mp3";
      g_cvBombTime.SetInt(58, false, false);
    }
    case 4:
    {
      song = "balloonbomb.mp3";
      g_cvBombTime.SetInt(38, false, false);
    }
    case 5:
    {
      song = "fraybomb.mp3";
      g_cvBombTime.SetInt(39, false, false);
    }
    case 6:
    {
      song = "familyguytheme.mp3";
      g_cvBombTime.SetInt(30, false, false);
    }
    case 7:
    {
      song = "notunusual.mp3";
      g_cvBombTime.SetInt(119, false, false);
    }
    case 8:
    {
      song = "hasan.mp3";
      g_cvBombTime.SetInt(80, false, false);
    }
    case 9:
    {
      song = "jared.mp3";
      g_cvBombTime.SetInt(30, false, false);
    }
    case 11:
    {
      song = "jaxson.mp3";
      g_cvBombTime.SetInt(60, false, false);
    }
    case 12:
    {
      song = "william.mp3";
      g_cvBombTime.SetInt(60, false, false);
    }
    case 13:
    {
      song = "bathroom.mp3";
      g_cvBombTime.SetInt(80, false, false);
    }
    case 14:
    {
      song = "freebird.mp3";
      g_cvBombTime.SetInt(548, false, false);
    }
    case 15:
    {
      song = "rebabomb.mp3";
      g_cvBombTime.SetInt(27, false, false);
    }
    case 16:
    {
      song = "whocares.mp3";
      g_cvBombTime.SetInt(380, false, false);
    }
  }
}
public void OnMapStart()
{
  ConVar g_cvBombTime = FindConVar("mp_c4timer");
}
public Action Event_player_ping(Event event, const char[] name, bool dontBroadcast)
{
  int ent = event.GetInt("entityid");
  float loc[3];
  loc[0] = event.GetFloat("x");
  loc[1] = event.GetFloat("y");
  loc[2] = event.GetFloat("z");
  char buf[64];
  return Plugin_Continue;
}
public Action Event_decoy(Event event, const char[] name, bool dontBroadcast)
{
  return Plugin_Handled;
}
public Action Event_BombPlant(Event event, const char[] name, bool dontBroadcast)
{
  float position[3];
  int user = event.GetInt("userid");
  int bomb = FindEntityByClassname(-1, "planted_c4");
  GetEntPropVector(bomb, Prop_Send, "m_vecOrigin", position)
  PrecacheSound(song);
  EmitAmbientSound(song, position, bomb, 100);
  return Plugin_Handled;
}
public Action Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
  int victim = event.GetInt("victim");
  int randomNumber = GetRandomInt(1,9);
  float position[3];
  if (randomNumber == 1)
  {
    GetEntPropVector(victim, Prop_Send, "m_vecOrigin", position)
    PrecacheSound("r2d2.mp3");
    EmitAmbientSound("r2d2.mp3", position, victim, 100);
  } else if (randomNumber == 2) {
    GetEntPropVector(victim, Prop_Send, "m_vecOrigin", position)
    PrecacheSound("tomscream.mp3");
    EmitAmbientSound("tomscream.mp3", position, victim, 100);
  } else if (randomNumber == 3) {
    GetEntPropVector(victim, Prop_Send, "m_vecOrigin", position)
    PrecacheSound("monsters.mp3");
    EmitAmbientSound("monsters.mp3", position, victim, 100);
  } else if (randomNumber == 4) {
    GetEntPropVector(victim, Prop_Send, "m_vecOrigin", position)
    PrecacheSound("nonono.mp3");
    EmitAmbientSound("nonono.mp3", position, victim, 100);
  } else if (randomNumber == 5) {
    GetEntPropVector(victim, Prop_Send, "m_vecOrigin", position)
    PrecacheSound("grapelady.mp3");
    EmitAmbientSound("grapelady.mp3", position, victim, 100);
  }
}
public Action cancelMessage(Handle timer, target)
{
  Event newevent_round = CreateEvent("round_start");
  if(IsClientInGame(target) && !IsFakeClient(target))
  {
    newevent_round.FireToClient(target);
  }
  newevent_round.Cancel();
  return Plugin_Handled;
}
