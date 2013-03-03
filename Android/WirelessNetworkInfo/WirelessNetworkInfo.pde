import android.net.wifi.WifiManager;    // required imports for wifi
import android.content.Context;
import android.net.wifi.ScanResult;     // required import for scanning networks
import java.util.List;                  // Java import for lists

/*
WIRELESS NETWORK INFO
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 This sketch gets two types of wireless network info: the state of wireless
 on the device and a list of all networks within range.
 
 Required permissions:
 1. ACCESS_WIFI_STATE
 2. CHANGE_WIFI_STATE
 
 See also:
 http://developer.android.com/reference/android/net/wifi/WifiManager.html
 
 CHALLENGES:
 1. Make a visualization of network signal strengths or other data; you could
    change scale based on signal strength, or color-code open/password-protected
    networks!
 */

WifiManager wifiManager;          // instance of the WifiManager for getting network details
List<ScanResult> networks;        // list of ScanResult objects, parsed later
String wifiState;                 // state of the wifi connection
PFont font;                       // font to display the wifi details

void setup() {

  // basic setup stuff
  background(25, 50, 75);
  smooth();
  noStroke();
  font = createFont("Monospaced", 36);
  textFont(font);
  textAlign(LEFT, TOP);
  fill(255);

  // check status of the wireless connection; store in a string so we can
  // display the result on the screen
  wifiManager = (WifiManager) getSystemService(Context.WIFI_SERVICE);
  int wifiStateCode = wifiManager.getWifiState();
  switch (wifiStateCode) {
  case 1: 
    wifiState = "Wifi disabled"; 
    break;
  case 3: 
    wifiState = "Wifi enabled"; 
    break;
  case 4: 
    wifiState = "Wifi state unknown"; 
    break;
  default: 
    wifiState = "Other wifi state detected: " + wifiState;
  }

  // try running a scan of available wifi networks
  if (wifiManager.startScan()) {                     // if successful... 
    networks = wifiManager.getScanResults();         // return list of results
  }
  else {
    // problem with scan - error message, etc can go here
  }

  // print the details of the networks
  text("WIFI STATE: " + wifiState, 150, 150);

  String allNetworks = "SSID, BSSID, SIGNAL STRENGTH, ENCRYPTION\n";    // create a printable string
  if (networks.size() > 0) {                      // if there are network results
    for (ScanResult network : networks) {         // iterate the networks
      String ssid = network.SSID;                 // human-readable network name
      String bssid = network.BSSID;               // network code
      int signalStrength = network.level;         // strength in dB
      String encryption = network.capabilities;   // type of encryption/password

      // format as a string and add to the printable string
      String networkDetails = ssid + ", " + bssid + ", " + signalStrength + ", " + encryption; 
      allNetworks += networkDetails + "\n";
    }
  }
  text(allNetworks, 150, 350);
}
