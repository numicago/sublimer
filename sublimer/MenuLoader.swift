//
//  MenuLoader.swift
//  sublimer
//
//  Created by Nuno Gonçalves on 23/11/14.
//  Copyright (c) 2014 Nuno Gonçalves. All rights reserved.
//

import Cocoa
import Foundation

class MenuLoader : NSObject {
    
    let appIcon = NSImage(named: "sublime_icon.png")
    
    let statusBar = NSStatusBar.systemStatusBar()
    
    var statusBarItem : NSStatusItem = NSStatusItem()
    
    var menu: NSMenu = NSMenu()
    
    var projectTypes:[String] = []
    
    var methods: [String: String] = ["": ""]
    
    var window:NSWindow
    
    let SUBLIME_PATH = "/usr/local/bin/sublime"
    
    init(window: NSWindow) {
        self.window = window
        super.init()
        setUpLinkedActionsBar()
        
        projectTypes = settingsFeed.getProjectTypeKeys()
        
        var length = projectTypes.count
        for var i = length-1; i >= 0; i-- {
            addMenuWithSubmenu(projectTypes[i], menuItemTitle: settingsFeed.getNameForProjectType(projectTypes[i]))
        }
        
        addExtraItems()
    }
    
    func setUpLinkedActionsBar() {
        statusBarItem = statusBar.statusItemWithLength(-1)
        
        appIcon!.size = NSSize(width: 18, height: 18)
        
        statusBarItem.image = appIcon
        statusBarItem.highlightMode = true
        statusBarItem.menu = self.menu
    }
    
    func addItemToMenu(title: NSString) {
        var item : NSMenuItem = NSMenuItem(title: title, action: "runSublime:", keyEquivalent: "")
        item.target = self
        statusBarItem.menu!.addItem(item)
    }
    
    func addMenuWithSubmenu(jsonKey: String, menuItemTitle: String) {
        var jsonItems = settingsFeed.getProjectsForType(jsonKey)["list"]
        
        let menuItem = NSMenuItem(title: menuItemTitle, action: nil, keyEquivalent: "")
        let menuItemMenu = NSMenu(title: "menu")
        
        for var i = 0; i < jsonItems.length; i++ {
            
            var name = jsonItems[i]["name"].toString() as String
            methods[name] = jsonItems[i]["location"].toString() as String
            
            var item : NSMenuItem = NSMenuItem(title: name, action: "runSublime:", keyEquivalent: "")
            item.target = self
            menuItemMenu.addItem(item)
        }
        
        statusBarItem.menu!.addItem(menuItem)
        statusBarItem.menu!.setSubmenu(menuItemMenu, forItem: menuItem)
        
        statusBarItem.menu!.addItem(NSMenuItem.separatorItem())
        
    }
    
    func addExtraItems() {
        var item = NSMenuItem(title: "Settings", action: "setWindowVisible:", keyEquivalent: "")
        item.target = self
        statusBarItem.menu!.addItem(item)
        
        item = NSMenuItem(title: "Quit", action: "Quit:", keyEquivalent: "")
        item.target = self
        statusBarItem.menu!.addItem(item)
    }
    
    func setWindowVisible(sender: AnyObject){
        //        appDelegate.applicationShouldHandleReopen()
//        self.window.makeKeyAndOrderFront()
        //http://stackoverflow.com/questions/4859974/make-nswindow-front-but-not-in-focus
        self.window.orderFrontRegardless()
    }
    
    var appDelegate:AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
    
    func Quit(send: AnyObject?) {
        NSApplication.sharedApplication().terminate(nil)
    }
    
    func runSublime(send: AnyObject?) {
        var item = send as NSMenuItem
        var projectPath = methods[item.title]! as String
        var task = NSTask()
        
        task.launchPath = SUBLIME_PATH
        task.arguments = [projectPath]
        
        task.launch()
    }
}