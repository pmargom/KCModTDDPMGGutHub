//
//  PMGWalletTableViewController.h
//  Wallet
//
//  Created by Pedro Martin Gomez on 2/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMGWallet;
@class PMGBroker;

@interface PMGWalletTableViewController : UITableViewController

-(id) initWithModel: (PMGWallet *) model broker:(PMGBroker *) broker;
@end
