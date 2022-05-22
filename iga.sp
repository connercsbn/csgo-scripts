#include <sourcemod>
#include <sdktools>


public Plugin:myinfo =
{
  name = "in-game audio",
  author = "conner",
  description = "Play in game audio",
  version = "1.0",
};

public OnMapStart()
{
  ArrayList fileList = plist();
  char fileBuffer[32];
  char path[64];
  path = "sound/"
  int arrSize = GetArraySize(fileList);
  for (int i=0; i<arrSize; i++)
  {
    GetArrayString(fileList, i, fileBuffer, sizeof(fileBuffer));
    StrCat(path, sizeof(path), fileBuffer);
    PrecacheSound(fileBuffer);
    AddFileToDownloadsTable(path);
    path = "sound/";
  }
}

public void OnPluginStart()
{
  RegConsoleCmd("sm_p", Command_play);
  RegConsoleCmd("sm_plist", Command_list);
  RegConsoleCmd("sm_stop", Command_stop);
  LoadTranslations("common.phrases.txt");
}

public Action Command_list(int client, int args)
{
  char fileBuffer[32];
  Handle fileList = plist();
  int arrSize = GetArraySize(fileList)
  for (int i=0; i<arrSize; i++)
  {
    GetArrayString(fileList, i, fileBuffer, sizeof(fileBuffer));
    ReplyToCommand(client, "%s", fileBuffer);
  }
}

public Action plist()
{
  ArrayList fileList = new ArrayList(48, 0)
  char fileBuffer[32];
  FileType filetype;
  DirectoryListing dL = OpenDirectory("sound");
  while (dL.GetNext(fileBuffer, 32, filetype))
    if (filetype == FileType_File)
      PushArrayString(fileList, fileBuffer);
  return fileList;
}

public Action Command_play(int client, int args)
{
  ArrayList fileList = plist();
  char soundTitle[32];
  char ext[] = ".mp3";
  GetCmdArg(1, soundTitle, sizeof(soundTitle));
  StrCat(soundTitle, 40, ext);
  int soundIndex = fileList.FindString(soundTitle);
  if (soundIndex > -1)
  {
    PrintToChatAll("Playing %s to everyone", soundTitle);
    EmitSoundToAll(soundTitle);
    return Plugin_Handled;
  }
  ReplyToCommand(client, "(spanking you) Sound not available.");
  SlapPlayer(client, 31, true);
  return Plugin_Handled;
}
public Action Command_stop(int client, int args)
{
  Event newevent_round = CreateEvent("round_start");
  if(IsClientInGame(client) && !IsFakeClient(client))
    newevent_round.FireToClient(client);
  newevent_round.Cancel();
  return Plugin_Handled;
}
