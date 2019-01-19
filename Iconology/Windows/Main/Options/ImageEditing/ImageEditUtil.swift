//
//  NSImage+Util.swift
//  Iconology
//
//  Created by Liam on 1/18/19.
//  Copyright © 2019 Liam Rosenfeld. All rights reserved.
//

import AppKit

func makeRep(at size: NSSize) -> NSBitmapImageRep {
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil,
                               pixelsWide: Int(size.width),
                               pixelsHigh: Int(size.height),
                               bitsPerSample: 8,
                               samplesPerPixel: 4,
                               hasAlpha: true,
                               isPlanar: false,
                               colorSpaceName: .calibratedRGB,
                               bytesPerRow: 0,
                               bitsPerPixel: 0)
    return rep!
}
