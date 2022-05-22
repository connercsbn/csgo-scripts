#include <sourcemod>
#include <sdktools>

public Plugin:myinfo =
{
  name =  "Load config",
  author = "conner",
  description = "Load configs based on map title",
  version = "1.0",
};


public void OnMapStart()
{
  CreateTimer(5.0, Read_Files);
}

public Action Read_Files(Handle timer)
{
  char[] defaultscfg = "cfg/sourcemod/defaults.cfg";
  char[] surfcfg = "cfg/sourcemod/surf.cfg";
  char[] ratscfg = "cfg/sourcemod/rats.cfg";
  char[] bhopcfg = "cfg/sourcemod/bhop.cfg";
  char[] hnscfg = "cfg/sourcemod/hns.cfg";
  char mapName[64];
  char mapType[32];
  readFileConfig(defaultscfg);
  GetCurrentMap(mapName, sizeof(mapName));
  if (
    StrContains(mapName, "rat", false) > -1 ||
    StrContains(mapName, "cheese", false) > -1
    )
  {
  ServerCommand("sm plugins unload influx_core");
  mapType = "rats";
  readFileConfig(defaultscfg);
  readFileConfig(ratscfg);
  }
  else if (StrContains(mapName, "surf", false) > -1)
  {
    readFileConfig(defaultscfg);
    readFileConfig(surfcfg);
    readFileConfig(bhopcfg);
    mapType = "surf";
  }
  else if (
    StrContains(mapName, "hns", false) > -1
    || StrContains(mapName, "home", false) > -1
    || StrContains(mapName, "hide", false) > -1
    || StrContains(mapName, "seek", false) > -1
    )
  {
    ServerCommand("sm plugins unload influx_core");
    readFileConfig(defaultscfg);
    readFileConfig(hnscfg);
    readFileConfig(bhopcfg);
    mapType = "hide and seek";
  }
  else if (StrContains(mapName, "insertion", false) > -1)
  {
    ServerCommand("setnextmap insertion");
  }
  else
  {
    ServerCommand("sm plugins unload influx_core");
    readFileConfig(defaultscfg);
    mapType = "regular";
  }
  PrintToConsoleAll("detecting %s map. executing %s config.", mapType, mapType);
}

public readFileConfig(char[] file){
	Handle hFile = OpenFile(file, "rt");
	char szReadData[128];
	if(hFile == INVALID_HANDLE)
    return

	while(!IsEndOfFile(hFile) && ReadFileLine(hFile, szReadData, sizeof(szReadData)))
		ServerCommand("%s", szReadData);
	CloseHandle(hFile);
}
