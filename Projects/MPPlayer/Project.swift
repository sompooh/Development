//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by USER on 2022/09/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let playerSettings: Settings = .settings(base: [:], debug: [:], release: [:], defaultSettings: .recommended)

let playerTargets = Project.appTargets(name: "MpPlayer",
                                       product: .framework,
                                       appDependencies: [
                                        .project(target: "Domain", path: "../DomainApp")
                                       ],
                                       testDependencies: [],
                                       resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                       deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                       infoPlist: .extendingDefault(with: [:]))

let playerProject = Project(name: "MpPlayer",
                            organizationName: "com.som.tuist.player",
                            packages: [],
                            settings: playerSettings,
                            targets: playerTargets,
                            schemes: [],
                            additionalFiles: [])
