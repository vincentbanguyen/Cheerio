import SwiftUI

@main
struct CheerioApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem?
    var popOver: NSPopover!
    @MainActor func applicationDidFinishLaunching (_ notification: Notification) {
    
        
        statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
    
        if let MenuButton = statusItem?.button {
            let image = NSImage(named: "dog")
            image!.size = NSSize(width: 20, height: 20)
            MenuButton.image = image
            MenuButton.action = #selector(MenuButtonToggle)
        }
        
        self.popOver = NSPopover()
        self.popOver.contentSize = NSSize(width: 300, height: 500)
        self.popOver.behavior = .transient
        self.popOver.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    @objc func MenuButtonToggle() {
        if let button = statusItem?.button {
            if popOver.isShown {
                self.popOver.performClose(nil)
            } else {
                popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}
