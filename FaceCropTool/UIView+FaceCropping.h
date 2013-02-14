//
//  UIView+FaceCropping.h
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FaceCropping)

- (CGRect)croppingRectForRect:(CGRect)cropRect faceRect:(CGRect)faceRect;

@end
