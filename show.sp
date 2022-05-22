#include <sourcemod>
#include <sdktools>

public Plugin:myinfo =
{
        name = "Show",
        author = "conner",
        description = "Show an image to everyone",
        version = "1.0",
};

public void OnPluginStart()
{
  RegAdminCmd("sm_show", Command_show, ADMFLAG_SLAY, "Show someone an image" );
  RegAdminCmd("sm_stopall", Command_stopall, ADMFLAG_SLAY, "stop everything" );
}
public Action Command_stopall(client, args)
{
  for (int i = 1; i <= MaxClients; i++)
  {
    if (IsClientInGame(i) && !IsFakeClient(i))
    {
      Handle timer = CreateTimer(0.1, cancelMessage, TIMER_FLAG_NO_MAPCHANGE);
    }
  }
  return Plugin_Handled;
}
public Action Command_show(client, args)
{
  char arg1[1024], imgTag[1024];
  char arg2[1024] = "7";
  GetCmdArg(1, arg1, sizeof(arg1));
  if (GetCmdArgs() > 1) {
    GetCmdArg(2, arg2, sizeof(arg2));
  }
  Format(imgTag, sizeof(imgTag), "<img src='%s'>", arg1);
  Event newevent_message = CreateEvent("cs_win_panel_round");
  newevent_message.SetString("funfact_token", imgTag);
  for (int i = 1; i <= MaxClients; i++)
  {
    if (IsClientInGame(i) && !IsFakeClient(i))
    {
      newevent_message.FireToClient(i);
      Handle timer = CreateTimer(StringToFloat(arg2), cancelMessage, TIMER_FLAG_NO_MAPCHANGE);
    }
  }
  return Plugin_Handled;
}
public Action cancelMessage(Handle timer)
{
  Event newevent_round = CreateEvent("round_start");
  for (int i = 1; i <= MaxClients; i++)
  {
    if (IsClientInGame(i) && !IsFakeClient(i))
    {
      newevent_round.FireToClient(i);
    }
  }
  newevent_round.Cancel();
  return Plugin_Handled;
}
