#ifndef FLUTTER_PLUGIN_SMART_TECH_PLUGIN_H_
#define FLUTTER_PLUGIN_SMART_TECH_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace smart_tech {

class SmartTechPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SmartTechPlugin();

  virtual ~SmartTechPlugin();

  // Disallow copy and assign.
  SmartTechPlugin(const SmartTechPlugin&) = delete;
  SmartTechPlugin& operator=(const SmartTechPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace smart_tech

#endif  // FLUTTER_PLUGIN_SMART_TECH_PLUGIN_H_
