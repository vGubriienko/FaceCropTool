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
    return [self crop:sourceSize toFitSize:fitSize withoutCroppingRect:featuresRect threshold:1.0f];
}

+ (CGRect)crop:(CGSize)sourceSize toFitSize:(CGSize)fitSize withoutCroppingRect:(CGRect)featuresRect threshold:(CGFloat)userThreshold {
    
    CGFloat aspect = fitSize.width / fitSize.height;
    CGFloat originalAspect = sourceSize.width / sourceSize.height;
    CGRect cropRect = CGRectMake(0.0f, 0.0f, sourceSize.width, sourceSize.height);
    
    if ( aspect / originalAspect > 1.0f ) {
        cropRect.size.height = roundf(sourceSize.width / aspect);
        cropRect.origin.y = roundf((sourceSize.height - cropRect.size.height) / 2.0f);
    } else {
        cropRect.size.width = roundf(sourceSize.height * aspect);
        cropRect.origin.x = roundf((sourceSize.width - cropRect.size.width) / 2.0f);
    }
    
    // in case cropRect contains faceRect do nothing
    if ( CGRectContainsRect(cropRect, featuresRect) || CGRectIsEmpty(featuresRect) ) {
        return cropRect;
    }
    
    // Calculating threshold
    CGFloat threshold = 0.0f;
    CGPoint featuresRectBottomRightPoint = CGPointMake(featuresRect.origin.x + featuresRect.size.width, featuresRect.origin.y + featuresRect.size.height);
    CGPoint cropRectBottomRightPoint = CGPointMake(cropRect.origin.x + cropRect.size.width, cropRect.origin.y + cropRect.size.height);
    
    if ( featuresRect.origin.x < cropRect.origin.x ) {
        threshold =  (cropRect.origin.x - featuresRect.origin.x) / cropRect.origin.x;
    } else if ( featuresRect.origin.y < cropRect.origin.y ) {
        threshold =  (cropRect.origin.y - featuresRect.origin.y) / cropRect.origin.y;
    } else if ( featuresRectBottomRightPoint.x > cropRectBottomRightPoint.x ) {
        threshold =  (featuresRectBottomRightPoint.x - cropRectBottomRightPoint.x) / (sourceSize.width - cropRectBottomRightPoint.x);
    } else if ( featuresRectBottomRightPoint.y > cropRectBottomRightPoint.y ) {
        threshold =  (featuresRectBottomRightPoint.y - cropRectBottomRightPoint.y) / (sourceSize.height - cropRectBottomRightPoint.y);
    }
    
    threshold = MIN(threshold, 1.0f);

    //move center of cropRect to center of faceRect
    CGRect resultRect =  CGRectOffset(cropRect,
                                      CGRectGetMidX(featuresRect) - CGRectGetMidX(cropRect) ,
                                      CGRectGetMidY(featuresRect) - CGRectGetMidY(cropRect));
    
    resultRect.origin.x = (resultRect.origin.x < 0.0f) ? 0.0f : resultRect.origin.x ;
    resultRect.origin.y = (resultRect.origin.y < 0.0f) ? 0.0f : resultRect.origin.y ;
    resultRect.origin.x = (resultRect.origin.x + resultRect.size.width > sourceSize.width) ? sourceSize.width - resultRect.size.width : resultRect.origin.x ;
    resultRect.origin.y = (resultRect.origin.y + resultRect.size.height > sourceSize.height) ? sourceSize.height - resultRect.size.height : resultRect.origin.y ;
    resultRect.origin.x = roundf(resultRect.origin.x);
    resultRect.origin.y = roundf(resultRect.origin.y);
    
    return (userThreshold >= threshold) ? resultRect : cropRect ;
}

@end
