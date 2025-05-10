function cli_args()
    
    call_by = dmenu_cmd 
    returns modified args without -l -p from config.ini

function dmenu_pass()
    
    call_by = dmenu_cmd 
    return correct command for passphrase

function dmenu_cmd()
    call_by = get_selection , choose_adapter , get_passphrase , delete_connection  
    Add in additional arguments & Prompt to dmenu_command
    if highlight is set then add suitable args for rofi/wofi 
    Add in passphrase prompt if dmenu_passphrase is set 
    
    returns modified command

function choose_adapter()
    called_by = run
    selects the adapter to be used by NM , if more than one adapter are present on system prompt the user about it

    returns chosen_adapter , or selected_adapter  

function create_other_actions()
    Add networking enable\disable option
    Add wifi enable\disable option
    --skip bluetooth
    Link state to callback functions
    Add wifi rescan option --issue rescan shows same list , requires restart to display new list 
    Add show wifi option 

    returns possible-actions list depending upon system state  

function rescan_wifi()
    Get client settinf for wifi rescan delay 
    Check each device recgonised by NM ,
        if device has wifi capability  -- Checking each device is not needed , dont request each device to scan indepedently 
            Request a wifi scan from that device 
            start an event loop to wait for async callback 
            notify client about wifi scan 
            Restart GUI 
        else 
            Handle Glib.Errors by notifying client 
    --No return

function ap_security()
    get security info of network 

    returns appropriate secuirty flag 

class Action()
    expects string name and function to execute for string variable 


function conn_matches_string(connection, adapter)
    checks whether the connection belongs to adapter not 
        -- connection belongs to adapter either by interface-name or adapter name 

    returns bool if connection belongs to adapter or not 

function process_ap(networkManager_connection, is_active, adapter)
    called_by = create_ap_actions , 
    Deavtivate if active 
    Activate if belongs to adapter and has some wireless setting 
    else Prompt for password

function deactivate_cb()
    notify if connnection was deactivated successfully 
    or notify error 


function activate_cb()
    notify if connnection was activatd successfully 
    or notify error 


function strength_icons(signal_strength)
    called_by = create_ap_actions 

    returns appropriate char for signal strength 

function create_ap_actions(ap, active_ap , active_connection, adapter)
    





