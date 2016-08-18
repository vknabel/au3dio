import PackageDescription

let package = Package(
    name: "Au3dio",
    targets: [
        Target(
            name: "Au3dio",
            dependencies: [
                "AbstractAu3dio",
                "DependencyAdditions"
            ]),
        Target(
            name: "AbstractAu3dio",
            dependencies: [
                "DependencyAdditions"
            ]),
        Target(
            name: "DependencyAdditions",
            dependencies: [])
    ],
    dependencies: [
        //.Package(
        //    url: "https://github.com/ReactiveX/RxSwift.git",
        //    versions: Version(2,6,0)..<Version(2,7,0)),
        .Package(
            url: "git@github.com:vknabel/RxSwift.git",
            versions: Version(2,6,1)..<Version(2,7,0)),
        .Package(
            url: "https://github.com/vknabel/ArrayMap.git",
            versions: Version(0,2,0)..<Version(0,3,0)),
        .Package(
            url: "https://github.com/vknabel/StateMachine.git",
            versions: Version(1,1,1)..<Version(2,0,0)),
        .Package(
            url: "https://github.com/vknabel/SwiftHook.git",
            versions: Version(1,0,7)..<Version(1,1,0)),
        /*.Package(
            url: "https://github.com/SwiftyJSON/SwiftyJSON.git",
            versions: Version(2,3,3)..<Version(3,0,0)),*/
        .Package(
            url: "https://github.com/vknabel/SwiftyJSON.git",
            versions: Version(2,3,4)..<Version(3,0,0)),
        /*.Package(
            url: "https://github.com/devxoul/Then.git",
            versions: Version(1,0,2)..<Version(2,0,0)),*/
        .Package(
            url: "https://github.com/vknabel/EasyInject.git",
            versions: Version(0,4,0)..<Version(0,5,0)),
        .Package(
            url: "https://github.com/vknabel/ValidatedExtension.git",
            versions: Version(3,0,0)..<Version(4,0,0))
    ]
)
