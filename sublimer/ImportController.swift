//
//  ImportController.swift
//  sublimer
//
//  Created by Nuno Gonçalves on 24/11/14.
//  Copyright (c) 2014 Nuno Gonçalves. All rights reserved.
//

import Cocoa

class ImportController: NSViewController {

    @IBOutlet weak var fileLocationLabel: NSTextField!
    
    @IBAction func selectFile(sender: AnyObject) {
        var fileChooserModal = NSOpenPanel()
        fileChooserModal.canChooseDirectories = false
        fileChooserModal.canChooseFiles = true
        fileChooserModal.allowsMultipleSelection = false
        if fileChooserModal.runModal() == NSOKButton {
            fileLocationLabel.stringValue = fileChooserModal.URLs[0].path!!
        }
    }
    
}
