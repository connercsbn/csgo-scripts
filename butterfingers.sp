#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdktools_functions>

public Plugin myinfo =
{
  name = "Butterfingers",
  author = "Conner",
  description = "Make someone drop their gun",
  version = "1.0",
}

public void OnPluginStart()
{
  RegConsoleCmd("sm_drop", Command_butter);
}
public Action Command_butter(client, args)
{
  Event newevent_message = CreateEvent("cs_win_panel_round");
  newevent_message.SetString("funfact_token", "<span class='fontSize-xxl' color='#7FFF00'>Whoops, butterfingers...</span>\n<img src='https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Trollface_non-free.png/220px-Trollface_non-free.png' width='220' height='183'>" );
  for (int i=1;i<MaxClients;i++)
  {
    if(IsClientInGame(i) && !IsFakeClient(i))
    {
      newevent_message.FireToClient(i);
    }
  }
  Handle timer = CreateTimer(5.0, cancelMessage, TIMER_FLAG_NO_MAPCHANGE);
  char arg1[32];
  GetCmdArg(1, arg1, sizeof(arg1));
  int target = FindTarget(client, arg1);
  if (target < 1) { return Plugin_Handled; }
  int weapon = GetEntPropEnt(target, Prop_Data, "m_hActiveWeapon");
  PrintToConsole(client, "weapon: %i, target: %i", weapon, target)
  CS_DropWeapon(target, weapon, true, false);
  return Plugin_Handled;
}
public Action:cancelMessage(Handle:timer)
{
  Event newevent_round = CreateEvent("round_start");
    for(int z = 1; z <= MaxClients; z++)
      if(IsClientInGame(z) && !IsFakeClient(z))
        newevent_round.FireToClient(z);
    newevent_round.Cancel();
    return Plugin_Handled;
}
