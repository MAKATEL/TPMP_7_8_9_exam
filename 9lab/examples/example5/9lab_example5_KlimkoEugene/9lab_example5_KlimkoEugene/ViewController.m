//
//  ViewController.m
//  9lab_example5_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//



#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITextField *cityFrom;
@property (weak, nonatomic) IBOutlet UITextField *cityTo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
