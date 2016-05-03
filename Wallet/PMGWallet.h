//
//  PMGWallet.h
//  Wallet
//
//  Created by Pedro Martin Gomez on 1/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMGMoney.h"

@interface PMGWallet : NSObject<PMGMoney>

@property (nonatomic, readonly) NSUInteger moneysCount;
@property (nonatomic, readonly) NSUInteger currencyCounts;

-(void) addCurrency: (NSString *) currency;                                 // adds a currency to the currency list
-(PMGMoney *)takeMoney: (NSString *) currency indexAt: (NSInteger) index;
-(NSMutableArray *) moneysForCurrency: (NSString *) currency;
-(BOOL) existCurrency: (NSString *) currency;                               // checks if a particular currency exists in the currency list
-(NSMutableArray *) getCurrencies;
-(NSString *) currencyAtIndex: (NSInteger) index;
-(NSInteger) moneysForCurrencyCount: (NSString *) currency;                 // get the number of money for a particular currency
-(NSInteger) calculateSumForCurrency: (NSString *) currency;                // calculates the sum of all moneys for a particular currency

@end
