#include <sourcemod>
#include <sdktools>

#include <influx/core>
#include <influx/stocks_core>


public Plugin myinfo =
{
    author = INF_AUTHOR,
    url = INF_URL,
    name = INF_NAME..." - Style - bumpmines",
    description = "",
    version = INF_VERSION
};

char weaponName[64];

public void OnPluginStart()
{
    RegConsoleCmd( "sm_w", Cmd_bumpmines, "" );
}

public void OnAllPluginsLoaded()
{
    if ( !Influx_AddStyle( BUMPMINES, "bumpmines", "bumpmines", "bumpmines" ) )
    {
        SetFailState( INF_CON_PRE..."Couldn't add style!" );
    }
}

public void OnPluginEnd()
{
    Influx_RemoveStyle( BUMPMINES );
}

public void Influx_OnRequestStyles()
{
    OnAllPluginsLoaded();
}

public Action Influx_OnSearchType( const char[] szArg, Search_t &type, int &value )
{
    if (StrEqual( szArg, "bumpmines", false ))
    {
        value = BUMPMINES;
        type = SEARCH_STYLE;

        return Plugin_Stop;
    }

    return Plugin_Continue;
}

public Action Cmd_bumpmines( int client, int args )
{
    if ( !client ) return Plugin_Handled;


    Influx_SetClientStyle( client, BUMPMINES );

    return Plugin_Handled;
}

public Action Influx_OnCheckClientStyle( int client, int style, float vel[3] )
{
    if ( style != BUMPMINES ) return Plugin_Continue;

    GetClientWeapon(client, weaponName, sizeof(weaponName));
    if (strcmp(weaponName, "weapon_bumpmine") != 0)
    {
      GivePlayerItem(client, "weapon_bumpmine");
    }


    return Plugin_Stop;
}
