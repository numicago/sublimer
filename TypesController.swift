//
//  TypesController.swift
//  sublimer
//
//  Created by Nuno Gonçalves on 22/11/14.
//  Copyright (c) 2014 Nuno Gonçalves. All rights reserved.
//

import Cocoa

class TypesController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        
    @IBOutlet var projectsView: NSView!
    @IBOutlet weak var typesTable: NSTableView!

    var data:[String] = settingsFeed.getProjectNames()
    
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int
    {
        return data.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn!, row: Int) -> NSView? {
        var cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn.identifier, owner: self) as NSTableCellView
        if(tableColumn.identifier ==  "TypeColumn")
        {
            cellView.textField!.stringValue = data[row]
            return cellView;
        }
        
        return cellView;
    }
    
}
