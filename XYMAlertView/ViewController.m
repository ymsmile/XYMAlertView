//
//  ViewController.m
//  XYMAlertView
//
//  Created by Michael on 6/9/13.
//  Copyright (c) 2013 Michael. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"viewController's view frame : %@",NSStringFromCGRect(self.view.frame));
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tapMe:(id)sender
{
    XYMAlertView *alert = [[XYMAlertView alloc]initWithTitle:@"Message Prompt"
                                                     message:@"It is successful for you to create a XYMAlertView!!"
                                                    delegate:self
                                                sureBtnTitle:@"Sure"
                                              cancleBtnTitle:@"Cancle"
                                                   superView:self.view];
//    [alert setXYMAlertViewBackgroudImageWithName:@"555.png"];
    [alert show];
    [alert release];
    
}

- (void)alertView:(XYMAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
