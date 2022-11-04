//
//  Project+Framework.swift
//  ProjectDescriptionHelpers
//
//  Created by USER on 2022/08/24.
//

import ProjectDescription

extension Project {
    public static func staticFrameworkTargets(name: String,
                                              frameworkDependencies: [TargetDependency],
                                              testDependencies: [TargetDependency]) -> [Target] {
        
        let source = Target(name: name,
                            platform: .iOS,
                            product: .staticFramework,
                            bundleId: "com.tuist.\(name)",
                            infoPlist: .default,
                            sources: ["Sources/**"],
                            resources: [],
                            dependencies: frameworkDependencies)
        
        return [source]
        
    }
}
