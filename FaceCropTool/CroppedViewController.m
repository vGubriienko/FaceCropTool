//
//  CroppedViewController.m
//  FaceCropTool
//
//  Created by Viktor Gubriienko on 19.02.13.
//  Copyright (c) 2013 Viktor Gubriienko. All rights reserved.
//

#import "CroppedViewController.h"

@interface CroppedViewController ()

@end

@implementation CroppedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cropped";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
