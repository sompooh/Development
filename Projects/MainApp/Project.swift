//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by USER on 2022/09/01.
//

import ProjectDescription
import ProjectDescriptionHelpers


let mainSettings: Settings = .settings(base: [:], debug: [:], release: [:], defaultSettings: .recommended)

let targets = Project.appTargets(name: "MainApp",
                                 product: .app,
                                 appDependencies: [],
                                 testDependencies: [],
                                 resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                 deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                 infoPlist: .extendingDefault(with: [
                                   "NSAppleMusicUsageDescription": "음악을 재생합니다.",
                                   "UILaunchScreen": ""
                                 ]))

let project = Project(name: "MainApp",
                      organizationName: "com.nami.tuist.main",
                      packages: [],
                      settings: mainSettings,
                      targets: targets,
                      schemes: [],
                      additionalFiles: [])

