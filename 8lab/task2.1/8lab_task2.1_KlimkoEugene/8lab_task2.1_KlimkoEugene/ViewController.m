//
//  ViewController.m
//  8lab_task2.1_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property CGPoint lastPoint;
@property (strong, nonatomic) IBOutlet UIImageView *canvas;
@property (strong, nonatomic) IBOutlet UIButton *redButton;
@property (strong, nonatomic) IBOutlet UIButton *greenButton;
@property (strong, nonatomic) IBOutlet UIButton *blueButton;
@property (strong, nonatomic) IBOutlet UISlider *wSlider;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property double red_;
@property double green_;
@property double blue_;
@property double width_;
@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect]; CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _width_); CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red_, _green_, _blue_, 1.0f); CGContextBeginPath(UIGraphicsGetCurrentContext()); CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
    _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.y, currentPoint.x);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()]; UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}
- (IBAction)redButtonPressed:(id)sender {
    _red_ = 1.0;
    _green_ = 0.0;
    _blue_ = 0.0;
}

- (IBAction)greenButtonPressed:(id)sender {
    _red_ = 0.0;
    _green_ = 1.0;
    _blue_ = 0.0;
}

- (IBAction)blueButtonPressed:(id)sender {
    _red_ = 0.0;
    _green_ = 0.0;
    _blue_ = 1.0;
}

- (IBAction)wChange:(id)sender {
    _width_ = _wSlider.value;
}

- (IBAction)saveClick:(id)sender {
    UIImageWriteToSavedPhotosAlbum(_canvas.image, nil, nil, nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _green_ = 0.5;
    _red_ = 0.5;
    _blue_ = 0.5;
    _width_ = 0.5;
    // Do any additional setup after loading the view.
}

@end
