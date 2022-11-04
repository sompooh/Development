//
//  Project+App.swift
//  ProjectDescriptionHelpers
//
//  Created by USER on 2022/08/24.
//

import ProjectDescription

extension Project {
    public static func appTargets(name: String,
                                  product: Product,
                                  appDependencies: [TargetDependency],
                                  testDependencies: [TargetDependency],
                                  resources: ResourceFileElements,
                                  deploymentTarget: ProjectDescription.DeploymentTarget? = nil,
                                  infoPlist: InfoPlist = .default) -> [Target] {
        

        
        let source = Target(name: name,
                             platform: .iOS,
                             product: product,
                             bundleId: "com.tuist.\(name)",
                             deploymentTarget: deploymentTarget,
                             infoPlist: infoPlist,
                             sources: ["Sources/**"],
                             resources: resources,
                             dependencies: appDependencies)
        
        return [source]
        
    }
}
