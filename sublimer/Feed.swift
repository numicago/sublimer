//
//  Feed.swift
//  sublimer
//
//  Created by Nuno Gonçalves on 22/11/14.
//  Copyright (c) 2014 Nuno Gonçalves. All rights reserved.
//

import Foundation

class Feed {
    
    var json: JSON?
    
    var projectTypes:[String] = []
    var projectNames:[String] = []
    
    init() {
        setSettingsUp()
    }
    
    private func filePath() -> String {
//        let bundle = NSBundle.mainBundle()
//        return bundle.pathForResource("applications", ofType: "json")!
        let documentsUrl = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0] as NSURL
        
        // add a filename
        return documentsUrl.URLByAppendingPathComponent("apps_temp.json").path!
    }
    
    private func setSettingsUp() {
        var error:NSError?
        if let content = NSString(contentsOfFile: filePath(), encoding: NSUTF8StringEncoding, error: &error) {
            json = JSON.parse(content)
            for (k:AnyObject, v:AnyObject) in json! {
                var keyString = k as String
                projectTypes.append(keyString)
                projectNames.append(json![keyString]["name"].toString())
            }
        } else {
            println(error)
            json = JSON.parse("")
        }
    }
    
    func getJson() -> JSON {
        return json!;
    }
    
    func getProjectTypeKeys() -> [String] {
        return projectTypes
    }
    
    func getProjectNames() -> [String] {
        return projectNames
    }
    
    func getNameForProjectType(type:String) -> String {
        return json![type]["name"].toString()
    }
    
    func getProjectsForType(type:String) -> JSON {
        return json![type]
    }
    
    func getProjectNamesForType(type:String) -> [String] {
        var json = getProjectsForType(type)["list"]
        var names:[String] = []
        for (k:AnyObject, v:AnyObject) in json {
            var keyString:Int = k as Int
            names.append(json[keyString]["name"].toString())
        }
        
        return names
    }
    
    func getProjectsArrayForType(type: String) -> [JSON] {
        var json = getProjectsForType(type)["list"]
        var projects:[JSON] = []
        for (k:AnyObject, v:AnyObject) in json {
            projects.append(v as JSON)
        }
        
        return projects
    }
    
    func addProjectType(type: String) {
        self.projectNames.append(type)
        self.projectTypes.append(type.lowercaseString)
    }
    
}