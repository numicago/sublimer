//
//  ExportController.swift
//  sublimer
//
//  Created by Nuno Gonçalves on 24/11/14.
//  Copyright (c) 2014 Nuno Gonçalves. All rights reserved.
//

import Cocoa

class ExportController: NSViewController {

    @IBOutlet weak var directoryLabel: NSTextField!
    
    @IBAction func chooseDirectory(sender: AnyObject) {
        var filename = "applications.json";
        
        var savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        if savePanel.runModal() == NSOKButton {

            var path = savePanel.URL?.path
            var exportFile = NSFileHandle(forWritingAtPath: path!)
            
            let data = settingsFeed.getJson().rawData(options: NSJSONWritingOptions.PrettyPrinted, error: nil)
            
            if(exportFile == nil) {
                NSFileManager().createFileAtPath(path!, contents: data, attributes: nil)
            } else {
                exportFile!.writeData(data! as NSData)
                exportFile!.closeFile()
            }
        }
    }
    
}
