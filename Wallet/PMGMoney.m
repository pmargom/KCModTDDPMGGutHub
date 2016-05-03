//
//  PMGMoney.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 30/4/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import "PMGMoney.h"
#import "NSObject+GNUStepAddons.h"
#import "PMGBroker.h"

#pragma mark - Private properties

@interface PMGMoney()

@end

@implementation PMGMoney

#pragma mark - Instance methods

+(instancetype) euroWithAmount: (NSNumber *) amount {
    return [[PMGMoney alloc] initWithAmount:amount
                                   currency: @"EUR"];
}

+(instancetype) dollarWithAmount: (NSNumber *) amount {
    return [[PMGMoney alloc] initWithAmount:amount
                                   currency: @"USD"];
}

#pragma mark - Class methods

-(id) initWithAmount: (NSNumber *) amount
            currency: (NSString *) currency{
    
    if (self == [super init]) {
        _amount = amount; // forma de empaquetar un tipo NSInteger en un objeto NSNumber
        _currency = currency;
    }
    
    return self;
}

// método abstracto
/*
 -(PMGMoney *) times: (NSInteger) multiplier {
 
 // no se debería llamar, sino que se debería de usar el de la subclase
 // _cmd es un parámetro oculto que recibe todo mensaje de ObjC y que indica el selector actual
 // otro similar es self, al que se puede acceder como _self cuando no te lo han pasado como parámetro
 return [self subclassResponsability: _cmd];
 
 }
 */

-(id<PMGMoney>) times: (NSInteger) multiplier {
    
    PMGMoney *newEuro = [[PMGMoney alloc]
                         initWithAmount: [NSNumber numberWithDouble: [self.amount doubleValue] * multiplier]
                         currency: self.currency];
    
    return newEuro;
    
}

-(id<PMGMoney>) plus: (PMGMoney *) money {
    
    PMGMoney *total = [[PMGMoney alloc] initWithAmount: [NSNumber numberWithDouble: [money.amount doubleValue] + [self.amount doubleValue]]
                                              currency: self.currency];
    return total;
    
}

-(PMGMoney *) reduceToCurrency: (NSString *) currency withBroker: (PMGBroker *) broker {
    
    PMGMoney *result;
    double rate = [[broker.rates objectForKey:[broker keyFromCurrency:self.currency toCurrency:currency]] doubleValue];
    
    // Comprobamos que divisas de origen y destino son las mismas
    if ([self.currency isEqual:currency]) {
        result = self;
    } else if (rate == 0){
        [NSException raise:@"NoConversionRateException" format:@"Must have a conversion from %@ to %@", self.currency, currency];
    } else {
        // Tenemos conversión
        double newAmount = [self.amount doubleValue] * rate;
        
        result = [[PMGMoney alloc] initWithAmount: [NSNumber numberWithDouble: newAmount] currency:currency];
    }
    
    return result;
    
}

#pragma mark - Overwritten

-(NSString *) description{
    return [NSString stringWithFormat:@"<%@: %@ %@>", [self class], self.currency, self.amount];
}

-(BOOL) isEqual:(id)object {
    
    // Dos objetos serán iguales, si los valores de todas sus propiedades son iguales
    //return self.amount == ((PMGDollar *)object).amount;
    if ([self.currency isEqual: [object currency]]) {
        return [[self amount] doubleValue] == [[object amount] doubleValue];
    }
    return NO;
    
}

-(NSUInteger) hash {
    
    return [self.amount integerValue];
    
}

@end




























