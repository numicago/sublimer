//
//  ProjectsController.swift
//  sublimer
//
//  Created by Nuno Gonçalves on 22/11/14.
//  Copyright (c) 2014 Nuno Gonçalves. All rights reserved.
//

import Cocoa

class ProjectsController: NSViewController, NSComboBoxDataSource {

    @IBOutlet var projectsView: NSView!
    
    @IBOutlet weak var typesComboBox: NSComboBox!
    
    var data = settingsFeed.getProjectNames()
    
    func reloadProjects() {
        data = settingsFeed.getProjectNames()
        typesComboBox?.reloadData()
    }

    
    func numberOfItemsInComboBox(aComboBox: NSComboBox) -> Int {
        return data.count
    }

    func comboBox(aComboBox: NSComboBox, objectValueForItemAtIndex index: Int) -> String {
        return data[index]
    }
    
    @IBAction func comboChange(sender: AnyObject) {
    }

    @IBOutlet weak var pathInput: NSTextField!
    
    @IBAction func chooseFile(sender: AnyObject) {
        var fileChooserModal = NSOpenPanel()
        fileChooserModal.canChooseDirectories = true
        fileChooserModal.canChooseFiles = false
        fileChooserModal.allowsMultipleSelection = false
        if fileChooserModal.runModal() == NSOKButton {
            pathInput.stringValue = fileChooserModal.URLs[0].path!!
        }
    }
    
    @IBAction func saveProject(sender: AnyObject) {
        var error: NSError?
        
        //settingsFeed.getJson().toString().writeToFile(path!, atomically: false, encoding: NSUTF8StringEncoding, error: &error)
        
        var settingsJson = settingsFeed.getJson().stringValue
        var str = (settingsJson).dataUsingEncoding(NSUTF8StringEncoding)!.description
            
        // get URL to the the documents directory in the sandbox
        let documentsUrl = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
        
        // add a filename
        let fileUrl = documentsUrl.URLByAppendingPathComponent("apps_temp.json")
        println(fileUrl)
        
        // write to it
        settingsJson.writeToURL(fileUrl, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        
        let content = String(contentsOfFile: fileUrl.path!, encoding: NSUTF8StringEncoding, error: nil)!
        println("content \(content)")
//        println(JSON.parse(content))
    }

}
