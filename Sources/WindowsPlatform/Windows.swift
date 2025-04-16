import Foundation
import SwiftlyCore

public struct Windows: Platform {
    public init() {}

    public var defaultSwiftlyHomeDirectory: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".swiftly", isDirectory: true)
    }

    public func swiftlyBinDir(_ ctx: SwiftlyCoreContext) -> URL {
        ctx.mockedHomeDir.map { $0.appendingPathComponent("bin", isDirectory: true) }
            ?? ProcessInfo.processInfo.environment["SWIFTLY_BIN_DIR"].map { URL(fileURLWithPath: $0) }
            ?? FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent(".swiftly/bin", isDirectory: true)
    }

    public func swiftlyToolchainsDir(_ ctx: SwiftlyCoreContext) -> URL {
        self.swiftlyHomeDir(ctx).appendingPathComponent("toolchains", isDirectory: true)
    }

    public var toolchainFileExtension: String {
        "exe"
    }

    public func install(_ ctx: SwiftlyCoreContext, from: URL, version: SwiftlyCore.ToolchainVersion, verbose: Bool) throws {
        fatalError("Not implemented")
    }

    public func extractSwiftlyAndInstall(_ ctx: SwiftlyCoreContext, from archive: URL) throws {
        fatalError("Not implemented")
    }

    public func uninstall(_ ctx: SwiftlyCoreContext, _ version: SwiftlyCore.ToolchainVersion, verbose: Bool) throws {
        fatalError("Not implemented")
    }

    public func getExecutableName() -> String {
        // FIXME: Is this right?
        "swiftly.exe"
    }

    public func getTempFilePath() -> URL {
        FileManager.default.temporaryDirectory.appendingPathComponent("swiftly-\(UUID()).pkg")
    }

    public func verifySwiftlySystemPrerequisites() throws {
        // All system prerequisites are there for swiftly on Windows
    }

    public func verifySystemPrerequisitesForInstall(_ context: SwiftlyCoreContext, platformName: String, version: SwiftlyCore.ToolchainVersion, requireSignatureValidation: Bool) async throws -> String? {
        // All system prerequisites should be there for Windows
        nil
    }

    public func verifyToolchainSignature(_ context: SwiftlyCoreContext, toolchainFile: SwiftlyCore.ToolchainFile, archive: URL, verbose: Bool) async throws {
        // No signature verification is required on Windows since the exe files have their own signing
        //  mechanism and the swift.org downloadables are trusted by stock Windows installations.
    }

    public func verifySwiftlySignature(_ context: SwiftlyCoreContext, archiveDownloadURL: URL, archive: URL, verbose: Bool) async throws {
        // No signature verification is required on Windows since the exe files have their own signing
        //  mechanism and the swift.org downloadables are trusted by stock Windows installations.
    }

    public func detectPlatform(_ ctx: SwiftlyCoreContext, disableConfirmation: Bool, platform: String?) async throws -> SwiftlyCore.PlatformDefinition {
        // No special detection required on Windows platform
        .windows
    }

    public func getShell() async throws -> String {
        // FIXME: don't hardcode the path
        "C:/Windows/System32/cmd.exe"
    }

    public func findToolchainLocation(_ ctx: SwiftlyCoreContext, _ toolchain: SwiftlyCore.ToolchainVersion) -> URL {
        self.swiftlyToolchainsDir(ctx).appendingPathComponent("\(toolchain.name)")
    }

    public func findToolchainBinDir(_ ctx: SwiftlyCoreContext, _ toolchain: ToolchainVersion) -> URL {
        self.findToolchainLocation(ctx, toolchain).appendingPathComponent("usr/bin")
    }

    public static let currentPlatform: any Platform = Windows()
}
