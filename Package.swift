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
        .Package(
            //url: "https://github.com/ReactiveX/RxSwift.git",
            url: "https://github.com/vknabel/RxSwift.git",
            versions: Version(2,6,0)..<Version(3,0,0)),
        .Package(
            url: "https://github.com/vknabel/Finite.git",
            versions: Version(2,0,0)..<Version(3,0,0)),
        .Package(
            url: "https://github.com/vknabel/EasyInject.git",
            versions: Version(0,4,0)..<Version(0,5,0)),
        .Package(
            url: "https://github.com/vknabel/ValidatedExtension.git",
            versions: Version(3,0,0)..<Version(4,0,0))
    ]
)
