//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by USER on 2022/09/01.
//

import ProjectDescription
import ProjectDescriptionHelpers

let dataSettings: Settings = .settings(base: [:], debug: [:], release: [:], defaultSettings: .recommended)

let dataTargets = Project.appTargets(name: "DataApp",
                                 product: .app,
                                 appDependencies: [
                                    .project(target: "Domain", path: "../DomainApp")
                                  ],
                                 testDependencies: [],
                                 resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                 deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                 infoPlist: .extendingDefault(with: [
                                   "NSAppleMusicUsageDescription": "음악을 재생합니다.",
                                   "UILaunchScreen": ""
                                 ])) +
                    Project.appTargets(name: "Data",
                                       product: .framework,
                                       appDependencies: [
                                        .project(target: "Domain", path: "../DomainApp")
                                       ],
                                       testDependencies: [],
                                       resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                       deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                       infoPlist: .extendingDefault(with: [:]))

let dataProject = Project(name: "DataApp",
                      organizationName: "com.som.tuist.data",
                      packages: [],
                      settings: dataSettings,
                      targets: dataTargets,
                      schemes: [],
                      additionalFiles: [])
