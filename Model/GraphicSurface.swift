//
//  GraphicSurface.swift
//  Warcraft
//
//  Created by My Nguyen on 1/29/17.
//  Copyright © 2017 My Nguyen. All rights reserved.
//

import Foundation

enum ESurfaceFormat {
    case ARGB32
    case RGB24
    case A8
    case A1
}

protocol CGraphicSurface {
    func Width() -> Int
    func Height() -> Int
    
    func Format() -> ESurfaceFormat
    func PixelAt(xpos: Int, ypos: Int) -> UInt32
    func Clear(xpos:Int, ypos:Int, width: Int, height: Int)
    func Duplicate() -> CGraphicSurface
    
//    virtual std::shared_ptr<CGraphicResourceContext> CreateResourceContext() = 0;
    
    func Draw(srcsurface: CGraphicSurface, dxpos: Int, dypos: Int, width: Int, height: Int, sxpos: Int, sypos: Int)
    func Copy(srcsurface: CGraphicSurface, dxpos: Int, dypos: Int, width: Int, height: Int, sxpos: Int, sypos: Int)
    func CopyMaskSurface(srcsurface: CGraphicSurface, dxpos: Int, dypos: Int, masksurface: CGraphicSurface, sxpos: Int, sypos: Int)
    func Transform(srcsurface: CGraphicSurface, dxpos: Int, dypos: Int, width: Int, height: Int, sxpos: Int, sypos: Int)        // MISSING void *calldata, TGraphicSurfaceTransformCallback callback
    
}
