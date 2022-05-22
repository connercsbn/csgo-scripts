#include <sourcemod>
#include <sdktools>
#include <cstrike>


public Plugin:myinfo =
{
  name = "Timeout",
  author = "conner",
  description = "Put someone in timeout",
  version = "1.0",
};

public void OnPluginStart()
{
  RegConsoleCmd("sm_timeout", Command_timeout, "Put someone in timeout" );
}
public Action Command_timeout(client, args)
{
  char arg1[32];
  GetCmdArg(1, arg1, sizeof(arg1));
  int target = FindTarget(client, arg1);
  if (target < 1)
  {
    PrintToConsole(client, "Target is < 0, stopping.")
    return Plugin_Handled;
  }
  ChangeClientTeam(target, 1);
  int team = GetClientTeam(target);
  PrintToConsole(client, "You are now on team %i", team);
  return Plugin_Handled;
}
