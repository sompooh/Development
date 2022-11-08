//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by USER on 2022/09/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let musicTargets = Project.appTargets(name: "MusicPlayApp",
                                      product: .app,
                                      appDependencies: [
                                        .project(target: "Domain", path: "../DomainApp"),
                                        .project(target: "Data", path: "../DataApp")
                                      ],
                                      testDependencies: [],
                                      resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                      deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                      infoPlist: .extendingDefault(with: [
                                        "NSAppleMusicUsageDescription": "음악을 재생합니다.",
                                        "UILaunchScreen": "",
                                        "UIBackgroundModes": ["audio"]
                                      ]))

let musicProject = Project(name: "MusicPlayApp",
                      organizationName: "com.som.tuist.music",
                      packages: [],
                      settings: .settings(base: [:], debug: [:], release: [:], defaultSettings: .recommended),
                      targets: musicTargets,
                      schemes: [],
                      additionalFiles: [])
