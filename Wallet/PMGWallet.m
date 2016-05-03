//
//  PMGWallet.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 1/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import "PMGWallet.h"

@interface PMGWallet()

@property (nonatomic, strong) NSMutableArray *moneys;
@property (nonatomic, strong) NSMutableArray *currencies; // array with just different currencies

@end

@implementation PMGWallet

#pragma mark - Properties

// Retrieves the number of moneys stored in moneys array
-(NSUInteger) moneysCount {
    
    return self.moneys.count;
    
}

// Retrieves the number of currencies stored in currencies array
-(NSUInteger) currencyCounts {

    return self.currencies.count;
    
}

#pragma mark - Class methods

// add a new currency to arrayCurrency after checking currency does not exist previously
-(void) addCurrency: (NSString *) currency {
    
    if (![self existCurrency: currency]){
        if (self.currencies == nil) {
            self.currencies = [NSMutableArray array];
        }
        [self.currencies addObject: currency];
    }
    
}

// Filter moneys array by currency and, after, retrieves the element located at particular index
-(PMGMoney *)takeMoney: (NSString *) currency indexAt: (NSInteger) index {
    
    return [[self moneysForCurrency: currency] objectAtIndex: index];
    
}

-(NSMutableArray *) moneysForCurrency: (NSString *) currency {
    
    NSMutableArray *moneysFiltered = [NSMutableArray array];
    for (PMGMoney *money in self.moneys) {
        if ([money.currency isEqual: currency]) {
            [moneysFiltered addObject: money];
        }
    }
    
    return moneysFiltered;
}

// Checks if a particular currency is stored in the currencies array
-(BOOL) existCurrency: (NSString *) currency {
    
    if (self.currencies == nil) {
        return 0;
    }
    
    if ([self currencyCounts] == 0) {
        return NO;
    }
    
    if ([self.currencies containsObject: currency]) {
        return YES;
    }
    
    return NO;
    
}

// Getter for currencies array
-(NSMutableArray *) getCurrencies {
    
    return self.currencies;
    
}

// Retrieves the currency for a particular index in the currencies array
-(NSString *) currencyAtIndex: (NSInteger) index {
    
    return [self.currencies objectAtIndex: index];
    
}

// Retrieves the number of moneys for a particular currency
-(NSInteger) moneysForCurrencyCount: (NSString *) currency {
    
    return [[self moneysForCurrency: currency] count];
}

// calculates the sum of all moneys for a particular currency
-(NSInteger) calculateSumForCurrency: (NSString *) currency {
    
    NSMutableArray *moneyFiltered = [self moneysForCurrency: currency];
    NSInteger sum = 0;
    for (PMGMoney *money in moneyFiltered) {
        sum += [money.amount integerValue];
    }
    
    return sum;
}

#pragma mark - Protocol methods

-(id) initWithAmount: (NSNumber *) amount currency: (NSString *) currency {
    
    if (self = [super init]) {
        
        PMGMoney *money = [[PMGMoney alloc] initWithAmount: amount currency: currency];
        _moneys = [NSMutableArray array];
        [_moneys addObject: money];
        
        // after adding a money, we have update the list of currencies
        _currencies = [NSMutableArray array];
        [_currencies addObject: currency];
    }
    return self;
}

-(id<PMGMoney>) plus: (PMGMoney *) money {
    
    [self.moneys addObject: money];
    [self addCurrency: money.currency];
    return self;
    
}

-(id<PMGMoney>) times: (NSInteger) multiplier {
    
    NSMutableArray *newMoneys = [NSMutableArray arrayWithCapacity: self.moneys.count];
    
    for (PMGMoney *each in self.moneys) {
        PMGMoney *newMoney = [each times: multiplier];
        [newMoneys addObject: newMoney];
    }
    self.moneys = newMoneys;
    return self;
}

// composite
-(id<PMGMoney>) reduceToCurrency: (NSString *) currency withBroker: (PMGBroker *) broker{
    
    PMGMoney *result = [[PMGMoney alloc] initWithAmount: 0 currency: currency];
    
    for (PMGMoney *each in self.moneys) {
        result = [result plus: [each reduceToCurrency: currency withBroker: broker]];
    }
    
    return result;
    
}


@end
