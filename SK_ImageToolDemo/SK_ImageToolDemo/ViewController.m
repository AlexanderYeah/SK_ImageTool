//
//  ViewController.m
//  SK_ImageToolDemo
//
//  Created by TrimbleZhang on 2019/1/24.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"
#import "SK_ImageTool.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *img1;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.'
    
    UIImage *image = [UIImage imageNamed:@"1.jpeg"];
    
    self.img1.image = [SK_ImageTool imageFromUIColor:[UIColor redColor] frame:CGRectMake(100, 200, 100, 100)];
    
    
    
    
    
}


@end
