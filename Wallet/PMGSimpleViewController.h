//
//  PMGSimpleViewController.h
//  Wallet
//
//  Created by Pedro Martin Gomez on 2/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMGSimpleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

- (IBAction)displayText:(id)sender;

@end
