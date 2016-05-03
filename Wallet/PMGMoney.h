//
//  PMGMoney.h
//  Wallet
//
//  Created by Pedro Martin Gomez on 30/4/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PMGMoney;
@class PMGBroker;

@protocol PMGMoney <NSObject>

-(id<PMGMoney>) plus: (PMGMoney *) money;
-(id) initWithAmount: (NSNumber *) amount currency: (NSString *) currency;
-(id<PMGMoney>) times: (NSInteger) multiplier;
-(PMGMoney *) reduceToCurrency: (NSString *) currency withBroker: (PMGBroker *) broker;

@end

// es un tipo de clase abstracta
@interface PMGMoney : NSObject<PMGMoney>

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, readonly) NSString *currency;

#pragma mark - Instance methods

+(id) euroWithAmount: (NSNumber *) amount;
+(id) dollarWithAmount: (NSNumber *) amount;

#pragma mark - Class methods



@end
