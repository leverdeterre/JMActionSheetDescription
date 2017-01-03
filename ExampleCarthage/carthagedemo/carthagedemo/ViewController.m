//
//  ViewController.m
//  carthagedemo
//
//  Created by jerome morissard on 03/01/2017.
//  Copyright © 2017 jerome morissard. All rights reserved.
//

#import "ViewController.h"
@import JMActionSheetDescription;

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    NSDate *minDate = [[NSDate date] dateByAddingTimeInterval:-60*60*24*1];
    NSDate *maxDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*60];
    NSDate *selectedDate = [NSDate date];
    
    [JMDatePickerActionSheet showDatePickerActionSheetMinDate:minDate
                                                      maxDate:maxDate
                                                 selectedDate:selectedDate
                                                  updateBlock:^(id selectedItem) {
                                                      NSLog(@"updateBlock called %@",selectedItem);
                                                  }
                                                validateBlock:^(id selectedItem) {
                                                    NSLog(@"validateBlock called %@",selectedItem);
                                                }
                                                        title:@"MyTitle"
                                             inViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
