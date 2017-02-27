/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Cocoa
import ApplicationServices

private var contextStack = [NSGraphicsContext]()
private var imageContextStack = [CGFloat]()

public func UIGraphicsPushContext(ctx: CGContext?)
{
    if let currCtx = NSGraphicsContext.current() {
        contextStack.append(currCtx)
    }
    
    NSGraphicsContext.setCurrent(NSGraphicsContext(cgContext: ctx!, flipped: true))
}

public func UIGraphicsPopContext() {
    if let aLast = contextStack.last {
        NSGraphicsContext.setCurrent(aLast)
        contextStack.removeLast()
    }
}

public func UIGraphicsGetCurrentContext() -> CGContext? {
    return NSGraphicsContext.current()?.cgContext
}

internal func _UIGraphicsGetContextScaleFactor(ctx: CGContext?) -> CGFloat {
    let rect = ctx!.boundingBoxOfClipPath
    let deviceRect = ctx!.convertToDeviceSpace(rect)
    let scale = deviceRect.size.height / rect.size.height
    return scale
}

public func UIGraphicsBeginImageContextWithOptions(size: CGSize, _ opaque: Bool, _ scale: CGFloat) {
    var scale = scale
    if scale == 0 {
       //TODO: Is this needed?
       // scale = UIScreen.mainScreen().scale
        if scale == 0 {
            scale = 1
        }
    }
    
    let width = Int(size.width * scale)
    let height = Int(size.height * scale)
    
    if (width > 0 && height > 0) {
        imageContextStack.append(scale)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let ctx = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: colorSpace, bitmapInfo: (opaque ? CGImageAlphaInfo.noneSkipFirst : CGImageAlphaInfo.premultipliedFirst).rawValue);
        
        //NOTE: New Implementation
        let firstMatrix = CGAffineTransform.init(translationX: CGFloat.init(0), y: CGFloat.init(height))
        let secondMatrix = CGAffineTransform.init(scaleX: CGFloat.init(1), y: CGFloat.init(-1))
        firstMatrix.concatenating(secondMatrix)
        
        
        //NOTE: Old implementation
        //CGAffineTransformMake(1, 0, 0, -1, 0, CGFloat(height))
        
        
        ctx!.concatenate(firstMatrix)
        ctx!.scaleBy(x: scale, y: scale);
        UIGraphicsPushContext(ctx: ctx);
    }
}

public func UIGraphicsBeginImageContext(size: CGSize)
{
    UIGraphicsBeginImageContextWithOptions(size: size, false, 1.0)
}

//NOTE: Needs UIImage from UXKit. Uncomment when function is needed.
/*
public func UIGraphicsGetImageFromCurrentImageContext() -> UIImage? {
    if let scale = imageContextStack.last {
        let theCGImage = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext())
        let image = UIImage(CGImage: theCGImage!, scale: scale, orientation: .Up)
        
        return image
    } else {
        return nil
    }
}
*/

public func UIGraphicsEndImageContext() {
    if let _ = imageContextStack.last {
        imageContextStack.removeLast()
        UIGraphicsPopContext()
    }
}

//NOTE: Throws errors. Uncomment when function is needed
/*
public func UIRectClip(rect: CGRect)
{
    CGContextClipToRect(UIGraphicsGetCurrentContext()!, rect);
}

public func UIRectFill(rect: CGRect)
{
    UIRectFillUsingBlendMode(rect, .Copy);
}

public func UIRectFillUsingBlendMode(rect: CGRect, _ blendMode: CGBlendMode)
{
    let c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    CGContextSetBlendMode(c, blendMode);
    CGContextFillRect(c, rect);
    CGContextRestoreGState(c);
}

public func UIRectFrame(rect: CGRect)
{
    CGContextStrokeRect(UIGraphicsGetCurrentContext(), rect)
}

public func UIRectFrameUsingBlendMode(rect: CGRect, _ blendMode: CGBlendMode)
{
    let c = UIGraphicsGetCurrentContext()
    CGContextSaveGState(c)
    CGContextSetBlendMode(c, blendMode)
    UIRectFrame(rect)
    CGContextRestoreGState(c)
}*/
