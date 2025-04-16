import Foundation
import SwiftlyCore
import SystemPackage

typealias sys = SwiftlyCore.SystemCommand
typealias fs = SwiftlyCore.FileSystem

public struct Windows: Platform {
    public init() {}

    public var defaultSwiftlyHomeDir: FilePath {
        fs.home / ".swiftly"
    }

    public func swiftlyBinDir(_ ctx: SwiftlyCoreContext) -> FilePath {
        ctx.mockedHomeDir.map { $0 / "bin" }
            ?? ProcessInfo.processInfo.environment["SWIFTLY_BIN_DIR"].map { FilePath($0) }
            ?? fs.home / ".swiftly/bin"
    }

    public func swiftlyToolchainsDir(_ ctx: SwiftlyCoreContext) -> FilePath {
        self.swiftlyHomeDir(ctx) / "toolchains"
    }

    public var toolchainFileExtension: String {
        "exe"
    }

    public func install(_ ctx: SwiftlyCoreContext, from: FilePath, version: SwiftlyCore.ToolchainVersion, verbose: Bool) async throws {
        fatalError("Not implemented")
    }

    public func extractSwiftlyAndInstall(_ ctx: SwiftlyCoreContext, from archive: FilePath) async throws {
        fatalError("Not implemented")
    }

    public func uninstall(_ ctx: SwiftlyCoreContext, _ version: SwiftlyCore.ToolchainVersion, verbose: Bool) async throws {
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

    public func verifyToolchainSignature(_ context: SwiftlyCoreContext, toolchainFile: SwiftlyCore.ToolchainFile, archive: FilePath, verbose: Bool) async throws {
        // No signature verification is required on Windows since the exe files have their own signing
        //  mechanism and the swift.org downloadables are trusted by stock Windows installations.
    }

    public func verifySwiftlySignature(_ context: SwiftlyCoreContext, archiveDownloadURL: URL, archive: FilePath, verbose: Bool) async throws {
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

    public func findToolchainLocation(_ ctx: SwiftlyCoreContext, _ toolchain: SwiftlyCore.ToolchainVersion) -> FilePath {
        self.swiftlyToolchainsDir(ctx) / "\(toolchain.name)"
    }

    public func findToolchainBinDir(_ ctx: SwiftlyCoreContext, _ toolchain: ToolchainVersion) -> FilePath {
        self.findToolchainLocation(ctx, toolchain) / "usr/bin"
    }

    public static let currentPlatform: any Platform = Windows()
}
