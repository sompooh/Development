//
//  Workspace.swift
//  GithubManifests
//
//  Created by USER on 2022/08/24.
//

import ProjectDescription

let appName = Environment.appName.getString(default: "MainApp")
let appNameIsMainApp = appName == "MainApp"

let projects: [Path] = appNameIsMainApp ? ["Projects/MainApp"] : []

let workspace = Workspace(name: "Development",
                          projects: projects)
