//
//  PMGMoneyTest.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 30/4/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMGMoney.h"

@interface PMGMoneyTest : XCTestCase

@end

@implementation PMGMoneyTest


 -(void) testThatTimesRisesException {
    
     //PMGMoney *money = [[PMGMoney alloc] initWithAmount: 1];
     //XCTAssertThrows([money times: 2], @"Should raise an exception");
     XCTAssert("Ya no hace falta");
}

-(void) testCurrencies {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    XCTAssertEqualObjects(@"EUR", [[PMGMoney euroWithAmount: [NSNumber numberWithInt: 1]] performSelector:@selector(currency)], @"The currency of euros should be EUR");
    XCTAssertEqualObjects(@"USD", [[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]] performSelector:@selector(currency)], @"The currency of euros should be USD");
#pragma clang diagnostic pop
}

/*
 -(void) testMultiplication {
 
 PMGMoney *euro = [[PMGMoney alloc] euroWithAmount: 5];
 PMGMoney *total = [euro times: 2];
 
 XCTAssertEqual(total.amount, 10 ,"Test pasado");
 
 }
 */
-(void) testMultiplication {
    
    PMGMoney *euro = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 5]];
    PMGMoney *ten = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 10]];
    PMGMoney *total = [euro times: 2];
    
    XCTAssertEqualObjects(total, ten,"Test pasado");
    
}


-(void) testEquality {
    
    PMGMoney *five = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 5]];
    PMGMoney *ten  = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 10]];
    PMGMoney *total = [five times: 2];
    
    // Hay que implementar IsEqual porque si no se usará el de NSObject y el test no pasará
    XCTAssertEqualObjects(ten, total, @"Equivalent objects should be equal!");
    XCTAssertEqualObjects([PMGMoney dollarWithAmount: [NSNumber numberWithInt: 4]],
                          [[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 2]] times: 2],
                          @"Equivalent objects should be equal!");
    
}

-(void) testDifferentCurrencies {
    
    PMGMoney *euro = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 1]];
    PMGMoney *dollar = [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal!");
    
}

-(void) testHash {
    
    PMGMoney *a = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 2]];
    PMGMoney *b = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 2]];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    XCTAssertEqual([[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]] hash],
                   [[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]] hash],
                   @"Equal objects must have same hash");
}

-(void) testAmountStorage {
    PMGMoney *euro = [PMGMoney euroWithAmount: [NSNumber numberWithInt: 2]];
    
    // con el siguiente praga, puedo ignorar warnings en el código incluido en su interior
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    // con el perform selector podemos llegar a una propiedad privada
    XCTAssertEqual(2, [[euro performSelector: @selector(amount)] integerValue], @"The value retrieved should be the same as the stored.");
    XCTAssertEqual(2, [[[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 2]]
                        performSelector: @selector(amount)] integerValue],
                   @"The value retrieved should be the same as the stored.");
#pragma diagnostic pop
    
}

-(void) testSimpleAddition {
    
    XCTAssertEqualObjects([[PMGMoney dollarWithAmount: [NSNumber numberWithInt: 5]]
                           plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 5]]],
                          [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 10]],
                          @"$5 + $5 = $10");
    
}

-(void) testDescription{
    PMGMoney *one = [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 1]];
    NSString *desc = @"<PMGMoney: USD 1>";
    XCTAssertEqualObjects([one description], desc, @"Description must match template");
}

@end
































