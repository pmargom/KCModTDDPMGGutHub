//
//  PMGWalletTest.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 1/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMGWallet.h"
#import "PMGMoney.h"
#import "PMGBroker.h"

@interface PMGWalletTest : XCTestCase

@end

@implementation PMGWalletTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// €40 + $20 = $100 2:1

-(void) testAdditionWithReduction {
    
    PMGBroker *broker = [PMGBroker new];
    [broker addRate: 2 fromCurrency:@"EUR" toCurrency: @"USD"];
    PMGWallet *wallet = [[PMGWallet alloc] initWithAmount: [NSNumber numberWithInt: 40] currency: @"EUR"];
    [wallet plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 20]]];
    PMGMoney *reduced = [broker reduce: wallet toCurrency: @"USD"];
    
    XCTAssertEqualObjects(reduced, [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 100]], @"€40 + $20 = $100 2:1");
}

-(void) testAddCurrency {
    
    PMGWallet *wallet = [PMGWallet new];
    NSString *currency = @"USD";
    [wallet addCurrency: currency];
    
    XCTAssertEqualObjects(currency, [[wallet getCurrencies] objectAtIndex: 0], @"USD currency was added to the currencies array");
    
}

-(void) testThatExistCurrency {
    
    PMGWallet *wallet = [PMGWallet new];
    NSString *currency = @"USD";
    [wallet addCurrency: currency];
    
    XCTAssertEqual(YES, [wallet existCurrency: currency], @"USD currency should exist in the currencies array");
    
}

@end
