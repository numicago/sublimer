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
            var data = content.dataUsingEncoding(NSUTF8StringEncoding)
            json = JSON(data: data!, options: nil, error: nil)

            for (projectTypeKey: String, projectType: JSON) in json! {
                var typeName = projectType["name"]
                var typeProjects = projectType["list"]
                
                projectTypes.append(projectTypeKey)
                projectNames.append(typeName.stringValue)
            }
        } else {
            println(error)
            json = JSON(data: "".dataUsingEncoding(NSUTF8StringEncoding)!, options: nil, error: nil)
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
        return json![type]["name"].stringValue
    }
    
    func getProjectsForType(type:String) -> JSON {
        return json![type]
    }
    
    func getProjectNamesForType(type:String) -> [String] {
        var json = getProjectsForType(type)["list"]
        var names:[String] = []
        for(projectIndex: String, project: JSON) in json["list"] {
            var name = project["name"]
            names.append(name.stringValue)
        }
        return names
    }
    
    func getProjectsArrayForType(type: String) -> [JSON] {
        var projectsForType = getProjectsForType(type)["list"]
        var projects:[JSON] = []
        
        for(projectIndex: String, project: JSON) in projectsForType {
            projects.append(project)
        }
        return projects
    }
    
    func addProjectType(type: String) {
        self.projectNames.append(type)
        self.projectTypes.append(type.lowercaseString)
    }
    
}