//
//  XcodePreset.swift
//  Iconology
//
//  Created by Liam Rosenfeld on 12/21/18.
//  Copyright © 2018 Liam Rosenfeld. All rights reserved.
//

import AppKit

final class XcodePreset: Preset {
    var name: String
    var sizes: [XcodeSizes]
    var useModifications: UseModifications
    var folderName: String
    var aspect: NSSize

    func save(_ image: NSImage, at url: URL, with prefix: String) {
        saveXcode(image, at: url, in: sizes, with: prefix)
    }

    init(name: String, sizes: [XcodeSizes], folderName: String, aspect: NSSize? = nil, fullEdit: Bool) {
        self.name = name
        self.sizes = sizes
        self.folderName = folderName
        self.aspect = aspect ?? NSSize(width: 1, height: 1)
        useModifications = UseModifications(
            background: true,
            scale: true,
            shift: true,
            round: fullEdit,
            padding: fullEdit,
            prefix: true
        )
    }

    final class XcodeSizes: Size {
        var name: String
        var size: NSSize
        var scale: Int
        var idiom: String
        var platform: String?
        var role: String?
        var subtype: String?

        init(name: String,
             w: Double,
             h: Double,
             scale: Int,
             idiom: String,
             platform: String? = nil,
             role: String? = nil,
             subtype: String? = nil) {
            self.name = name
            size = NSSize(width: w, height: h)
            self.scale = scale
            self.idiom = idiom
            self.platform = platform
            self.role = role
            self.subtype = subtype
        }
    }
}
