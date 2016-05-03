//
//  PMGBrokerTest.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 1/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMGMoney.h"
#import "PMGBroker.h"

@interface PMGBrokerTest : XCTestCase

@property (nonatomic, strong) PMGBroker *emptyBroker;
@property (nonatomic, strong) PMGMoney *oneDollar;

@end

@implementation PMGBrokerTest

- (void)setUp {
    [super setUp];
    self.emptyBroker = [PMGBroker new];
    self.oneDollar = [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]];
}

- (void)tearDown {
    [super tearDown];
    self.emptyBroker = nil;
    self.oneDollar = nil;
}

-(void) testSimpleReduction {
    
    PMGMoney *sum = [[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 5]] plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 5]]];
    
    PMGMoney *reduced = [self.emptyBroker reduce: sum toCurrency: @"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Covertion to same currency should be a NO");
    
}

// $10 == €5 2:1
-(void) testReduction {
    
    [self.emptyBroker addRate: 2 fromCurrency: @"EUR" toCurrency: @"USD"];
    PMGMoney *dollars = [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 10]];
    PMGMoney *euros = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 5]];
    PMGMoney *converted = [self.emptyBroker reduce: dollars toCurrency: @"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
}

-(void) testHashIsAmount {
    
    PMGMoney *one = [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]];
    
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
}

-(void) testDecription {
    
    PMGMoney *one = [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]];
    NSString *desc = @"<PMGMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
}

-(void) testThatNoRateRaisesException {
    
    XCTAssertThrows([self.emptyBroker reduce: self.oneDollar toCurrency: @"EUR"], @"Not rates should cause exception");
    
}

-(void) testThatNilConvertionDoesNotChangeMoney {
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce: self.oneDollar toCurrency: @"USD"], @"A nil convertion should have no effect");
    
}

-(void) testTakeRateWhenNoRatesWereConfigured {
    
    XCTAssertEqual(0, [[self.emptyBroker takeRate: @"USD" toCurrency: @"EUR"] integerValue], @"There no rates configured yet");
    
}

@end



































