//
//  ViewController.m
//  8lab_Example1_KlimkoEugene
//
//  Created by MacOSExi on 16.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property CGPoint lastPoint;
@property (strong, nonatomic) IBOutlet UIImageView *canvas;

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
    [[[self canvas] image] drawInRect:drawRect]; CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound); CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0f); CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0f, 0.0f, 0.0f, 1.0f); CGContextBeginPath(UIGraphicsGetCurrentContext()); CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
    _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.y, currentPoint.x);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()]; UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
