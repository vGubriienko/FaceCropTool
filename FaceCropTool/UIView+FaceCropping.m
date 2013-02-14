//
//  UIView+FaceCropping.m
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "UIView+FaceCropping.h"

@implementation UIView (FaceCropping)

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

@end
