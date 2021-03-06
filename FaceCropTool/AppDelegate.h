//
//  AppDelegate.h
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class CroppedViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) CroppedViewController *croppedViewController;

@property (nonatomic) CGRect cropRect;

@end
