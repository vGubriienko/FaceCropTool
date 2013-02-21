//
//  ViewController.m
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "ViewController.h"
#import "CropView.h"
#import "UIView+FaceCropping.h"
#import "AppDelegate.h"
#import "CroppedViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet CropView *cropView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tabBarItem.title = @"Original";
    
    _cropView.faceRect = CGRectMake(140.0f, 0.0f, 70.0f, 85.0f);
    _cropView.cropRect = CGRectMake(0.0f, 0.0f, 60.0f, 200.0f); //[_cropView aspectFillRectForSize:CGSizeMake(2.0f, 4.0f)];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePanMoved:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [_cropView addGestureRecognizer:panRecognizer];
    
    [self cropImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

-(void)gesturePanMoved:(UIPanGestureRecognizer*)sender {
    
    static CGRect faceRect;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        faceRect = _cropView.faceRect;
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGRect deltaRect = faceRect;
        CGPoint tr = [sender translationInView:_cropView];
        deltaRect.origin.x += tr.x;
        deltaRect.origin.y += tr.y;
        _cropView.faceRect = deltaRect;

    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self cropImage];
    }
}

- (void)cropImage {
    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    CGRect cropRect = [UIView crop:image.size toFitSize:_cropView.cropRect.size withoutCroppingRect:_cropView.faceRect];
    
    cropRect.origin.y = image.size.height - cropRect.size.height - cropRect.origin.y; // FIX to CIImage coordinate system
    
    CIImage *croppedCIImage = [[CIImage imageWithCGImage:image.CGImage] imageByCroppingToRect:cropRect];
    CroppedViewController *croppedViewCtrl = [(AppDelegate*)[UIApplication sharedApplication].delegate croppedViewController];
    UIImage *croppedImage = [UIImage imageWithCGImage:[[CIContext contextWithOptions:nil] createCGImage:croppedCIImage
                                                                                               fromRect:croppedCIImage.extent]];
    croppedViewCtrl.imageView.image = croppedImage;
}


@end
