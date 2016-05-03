//
//  PMGSimpleViewController.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 2/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import "PMGSimpleViewController.h"

@interface PMGSimpleViewController ()

@end

@implementation PMGSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)displayText:(id)sender {

    UIButton *button = sender;
    self.displayLabel.text = button.titleLabel.text;
    
}


@end
