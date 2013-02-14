//
//  ViewController.m
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 14.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "ViewController.h"
#import "CropView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet CropView *cropView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _cropView.faceRect = CGRectMake(140.0f, 0.0f, 70.0f, 85.0f);
    _cropView.cropRect = CGRectMake(0.0f, 200.0, 100.0f, 300.0f);
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePanMoved:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [_cropView addGestureRecognizer:panRecognizer];
    
    
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
}


@end
