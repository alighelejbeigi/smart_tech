#include "include/smart_tech/smart_tech_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "smart_tech_plugin.h"

void SmartTechPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  smart_tech::SmartTechPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
