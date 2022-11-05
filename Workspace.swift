//
//  Workspace.swift
//  GithubManifests
//
//  Created by USER on 2022/08/24.
//

import ProjectDescription

//let appName = Environment.appName.getString(default: "MainApp")
//let appNameIsMainApp = appName == "MainApp"
//appNameIsMainApp ? ["Projects/MainApp", "Projects/DataApp"] : []

let projects: [Path] = ["Projects/MusicPlayApp", "Projects/DataApp", "Projects/DomainApp"]

let workspace = Workspace(name: "Development",
                          projects: projects)
