import Cocoa
import ApplicationServices

guard let cc = NSWorkspace.shared.runningApplications.first(where: {
    $0.bundleIdentifier == "com.apple.controlcenter"
}) else { exit(1) }

let app = AXUIElementCreateApplication(cc.processIdentifier)

var menuBarVal: AnyObject?
guard AXUIElementCopyAttributeValue(app, kAXMenuBarAttribute as CFString, &menuBarVal) == .success,
      let menuBar = menuBarVal else { exit(1) }

var childrenVal: AnyObject?
guard AXUIElementCopyAttributeValue(menuBar as! AXUIElement, kAXChildrenAttribute as CFString, &childrenVal) == .success,
      let items = childrenVal as? [AXUIElement], items.count >= 3 else { exit(1) }

AXUIElementPerformAction(items[2], kAXPressAction as CFString)
