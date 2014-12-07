import Cocoa

var settingsFeed = Feed()

class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var menuLoader: MenuLoader!
    
    var typesController:TypesController?
    var projectController:ProjectsController?
    var exportController:ExportController?
    var importController:ImportController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        typesController = TypesController(nibName: "TypesController", bundle: nil)
        projectController = ProjectsController(nibName: "ProjectsController", bundle: nil)
        exportController = ExportController(nibName: "ExportController", bundle: nil)
        importController = ImportController(nibName: "ImportController", bundle: nil)
        
        menuLoader = MenuLoader(window: window)
        
        window.center()
        window.contentView.addSubview(typesController!.view)
        var contentView = self.window.contentView as NSView
        typesController!.view.frame = contentView.bounds;
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func switchToolBarItem(sender: AnyObject) {
        var item = sender as NSToolbarItem;
        var tag = item.tag
        
        if tag == 0 {
            window.contentView = typesController!.view
        } else if tag == 1 {
            window.contentView = projectController!.view
        } else if tag == 2 {
            window.contentView = importController!.view
        } else if tag == 3 {
            window.contentView = exportController!.view
        }
        
    }
    

}
    
