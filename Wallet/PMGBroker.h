//
//  PMGBroker.h
//  Wallet
//
//  Created by Pedro Martin Gomez on 1/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMGMoney.h"

@interface PMGBroker : NSObject

@property (nonatomic, strong) NSMutableDictionary *rates;

-(PMGMoney *) reduce: (id<PMGMoney>) money toCurrency: (NSString *) currency;
-(void) addRate: (NSInteger) rate fromCurrency: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency;
-(NSString *) keyFromCurrency: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency;
-(NSNumber *) takeRate: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency;

@end
