//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 김유미 on 2022/11/07.
//

import ProjectDescription
import ProjectDescriptionHelpers

let domainSettings: Settings = .settings(base: [:], debug: [:], release: [:], defaultSettings: .recommended)

let domainTargets = Project.appTargets(name: "DomainApp",
                                       product: .app,
                                       appDependencies: [],
                                       testDependencies: [],
                                       resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                       deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                       infoPlist: .extendingDefault(with: [
                                        "NSAppleMusicUsageDescription": "음악을 재생합니다.",
                                        "UILaunchScreen": ""
                                       ])) +
                    Project.appTargets(name: "Domain",
                                       product: .framework,
                                       appDependencies: [],
                                       testDependencies: [],
                                       resources: ["Resources/**", "Sources/**/*.storyboard", "Sources/**/*.xib"],
                                       deploymentTarget: .iOS(targetVersion: "14.0", devices: DeploymentDevice.iphone),
                                       infoPlist: .extendingDefault(with: [:]))


let domainProject = Project(name: "DomainApp",
                      organizationName: "com.som.tuist.domain",
                      packages: [],
                      settings: domainSettings,
                      targets: domainTargets,
                      schemes: [],
                      additionalFiles: [])
