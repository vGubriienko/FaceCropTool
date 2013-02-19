//
//  UIView+FaceCropping.m
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "UIView+FaceCropping.h"

@implementation UIView (FaceCropping)

- (CGRect)aspectFillRectForSize:(CGSize)size {
    CGSize aspectFillSize = self.bounds.size;
    CGFloat aspect = size.width / size.height;
    CGFloat originalAspect = aspectFillSize.width / aspectFillSize.height;

    if ( aspect / originalAspect > 1.0f ) {
        aspectFillSize.height = aspectFillSize.width / aspect;
    } else {
        aspectFillSize.width = aspectFillSize.height * aspect;
    }
    
    return CGRectMake(0.0f, 0.0f, aspectFillSize.width, aspectFillSize.height);
}

- (CGRect)croppingRectForRect:(CGRect)cropRect faceRect:(CGRect)faceRect {
    
    // in case cropRect contains faceRect do nothing
    if ( CGRectContainsRect(cropRect, faceRect) ) {
        return cropRect;
    }
    
    //move center of cropRect to center of faceRect
    CGRect resultRect =  CGRectOffset(cropRect,
                                      CGRectGetMidX(faceRect) - CGRectGetMidX(cropRect) ,
                                      CGRectGetMidY(faceRect) - CGRectGetMidY(cropRect));
    
    
    // update origin in case we cross borders of
    CGSize viewSize = self.bounds.size;
    resultRect.origin.x = (resultRect.origin.x < 0.0f) ? 0.0f : resultRect.origin.x ;
    resultRect.origin.y = (resultRect.origin.y < 0.0f) ? 0.0f : resultRect.origin.y ;
    resultRect.origin.x = (resultRect.origin.x + resultRect.size.width > viewSize.width) ? viewSize.width - resultRect.size.width : resultRect.origin.x ;
    resultRect.origin.y = (resultRect.origin.y + resultRect.size.height > viewSize.height) ? viewSize.height - resultRect.size.height : resultRect.origin.y ;
    
    return resultRect;
}

+ (CGRect)crop:(CGSize)sourceSize toFitSize:(CGSize)fitSize withoutCroppingRect:(CGRect)featuresRect {
    
    CGFloat aspect = fitSize.width / fitSize.height;
    CGFloat originalAspect = sourceSize.width / sourceSize.height;
    CGSize resultSize = sourceSize;
    
    if ( aspect / originalAspect > 1.0f ) {
        resultSize.height = roundf(sourceSize.width / aspect);
    } else {
        resultSize.width = roundf(sourceSize.height * aspect);
    }
    
    CGRect cropRect = CGRectMake(0.0f, 0.0f, resultSize.width, resultSize.height);
    
    // in case cropRect contains faceRect do nothing
    if ( CGRectContainsRect(cropRect, featuresRect) ) {
        return cropRect;
    }
    
    //move center of cropRect to center of faceRect
    cropRect =  CGRectOffset(cropRect,
                             CGRectGetMidX(featuresRect) - CGRectGetMidX(cropRect) ,
                             CGRectGetMidY(featuresRect) - CGRectGetMidY(cropRect));
    
    cropRect.origin.x = (cropRect.origin.x < 0.0f) ? 0.0f : cropRect.origin.x ;
    cropRect.origin.y = (cropRect.origin.y < 0.0f) ? 0.0f : cropRect.origin.y ;
    cropRect.origin.x = (cropRect.origin.x + cropRect.size.width > sourceSize.width) ? sourceSize.width - cropRect.size.width : cropRect.origin.x ;
    cropRect.origin.y = (cropRect.origin.y + cropRect.size.height > sourceSize.height) ? sourceSize.height - cropRect.size.height : cropRect.origin.y ;
    cropRect.origin.x = roundf(cropRect.origin.x);
    cropRect.origin.y = roundf(cropRect.origin.y);
    
    return cropRect;
}

@end
