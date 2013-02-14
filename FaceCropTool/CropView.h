//
//  CropView.h
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropView : UIView

@property (nonatomic) CGRect faceRect;
@property (nonatomic) CGRect cropRect;
@property (nonatomic, readonly) CGRect resultCropRect;

@end
