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
}
