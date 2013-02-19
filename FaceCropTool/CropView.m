//
//  CropView.m
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "CropView.h"
#import "UIView+FaceCropping.h"

@implementation CropView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing image
    [[UIImage imageNamed:@"test.jpg"] drawInRect:rect];

    // Drawing face rect
    [[UIColor yellowColor] setStroke];
    UIBezierPath *facePath = [UIBezierPath bezierPathWithRect:_faceRect];
    facePath.lineWidth = 3.0f;
    [facePath stroke];
    
    // Drawing original crop rect
    [[UIColor greenColor] setStroke];
    UIBezierPath *originalCropPath = [UIBezierPath bezierPathWithRect:_cropRect];
    originalCropPath.lineWidth = 3.0f;
    [originalCropPath stroke];
    
    // Drawing original crop rect
    [[UIColor blueColor] setStroke];
    UIBezierPath *resultCropPath = [UIBezierPath bezierPathWithRect:self.resultCropRect];
    resultCropPath.lineWidth = 3.0f;
    [resultCropPath stroke];
    
}

#pragma mark - DynamicProperties

- (void)setFaceRect:(CGRect)faceRect {
    _faceRect = faceRect;
    [self setNeedsDisplay];
}

- (void)setCropRect:(CGRect)cropRect {
    _cropRect = cropRect;
    [self setNeedsDisplay];
}

- (CGRect)resultCropRect {
    return [UIView crop:self.bounds.size toFitSize:_cropRect.size withoutCroppingRect:_faceRect];
    //[self croppingRectForRect:_cropRect faceRect:_faceRect];
}

@end
