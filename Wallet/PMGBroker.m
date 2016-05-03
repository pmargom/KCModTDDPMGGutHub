//
//  PMGBroker.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 1/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import "PMGBroker.h"
#import "PMGMoney.h"

@interface PMGBroker()



@end

@implementation PMGBroker

-(id)init {
    
    if (self = [super init]) {
        _rates = [@{} mutableCopy]; //@{} siempre devuelve la versión mutable
    }
    
    return self;
}

-(PMGMoney *) reduce: (id<PMGMoney>) money toCurrency: (NSString *) currency {
    
    // double dispatch
    return [money reduceToCurrency: currency withBroker: self];
    
}

-(void) addRate: (NSInteger) rate fromCurrency: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency {
    
    [self.rates setObject:@(rate) forKey:[self keyFromCurrency: fromCurrency toCurrency: toCurrency]];
    [self.rates setObject:@(1.0 / rate) forKey:[self keyFromCurrency: toCurrency toCurrency: fromCurrency]];
}

-(NSNumber *) takeRate: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency {
    
    if ([self.rates count] == 0) {
        return 0;
    }
    
    if ([self.rates objectForKey: [self keyFromCurrency: fromCurrency toCurrency: toCurrency]] == nil) {
        return 0;
    }
    
    NSNumber *rateValue = [self.rates objectForKey: [self keyFromCurrency: fromCurrency toCurrency: toCurrency]];
    
    return rateValue;

    
}

#pragma mark - utils

-(NSString *) keyFromCurrency: (NSString *) fromCurrency toCurrency: (NSString *) toCurrency {
    
    return [NSString stringWithFormat: @"%@-%@", fromCurrency, toCurrency];
    
}

@end





























