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
    
    var titleVsAction: [String: String] = ["": ""]
    
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
    
    func addMenuWithSubmenu(type: String, menuItemTitle: String) {
        var projectsForType = settingsFeed.getProjectsForType(type)["list"]
        
        let menuItem = NSMenuItem(title: menuItemTitle, action: nil, keyEquivalent: "")
        let menuItemMenu = NSMenu(title: "menu")
        
        for(projectIndex: String, project: JSON) in projectsForType {
            var name = project["name"].stringValue
            titleVsAction[name] = project["location"].stringValue
            var item : NSMenuItem = NSMenuItem(title: name, action: "runSublime:", keyEquivalent: "")
            item.target = self
            menuItemMenu.addItem(item)
        }
                
        statusBarItem.menu!.addItem(menuItem)
        statusBarItem.menu!.setSubmenu(menuItemMenu, forItem: menuItem)
        
        statusBarItem.menu!.addItem(NSMenuItem.separatorItem())
        
    }
    
    func insertMenuWithSubmenu(type: String, menuItemTitle: String) {
        statusBarItem.menu!.addItem(NSMenuItem.separatorItem())
        var projectsForType = settingsFeed.getProjectsForType(type)["list"]
        
        let menuItem = NSMenuItem(title: menuItemTitle, action: nil, keyEquivalent: "")
        let menuItemMenu = NSMenu(title: "menu")
        
        for(projectIndex: String, project: JSON) in projectsForType {
            var name = project["name"].stringValue
            titleVsAction[name] = project["location"].stringValue
            var item : NSMenuItem = NSMenuItem(title: name, action: "runSublime:", keyEquivalent: "")
            item.target = self
            menuItemMenu.addItem(item)
        }
        let menuItemsCount = statusBarItem.menu!.numberOfItems
        println("menu items \(menuItemMenu.numberOfItems)")
        statusBarItem.menu!.insertItem(menuItem, atIndex: menuItemsCount - 3)//addItem(menuItem)
        statusBarItem.menu!.setSubmenu(menuItemMenu, forItem: menuItem)
        statusBarItem.menu!.insertItem(NSMenuItem.separatorItem(), atIndex: menuItemsCount - 2)
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
        //http://stackoverflow.com/questions/4859974/make-nswindow-front-but-not-in-focus
        self.window.orderFrontRegardless()
    }
    
    var appDelegate:AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
    
    func Quit(send: AnyObject?) {
        NSApplication.sharedApplication().terminate(nil)
    }
    
    func runSublime(send: AnyObject?) {
        var item = send as NSMenuItem
        var projectPath = titleVsAction[item.title]! as String
        var task = NSTask()
        
        task.launchPath = SUBLIME_PATH
        println(projectPath)
        task.arguments = [projectPath]
        
        task.launch()
    }
}