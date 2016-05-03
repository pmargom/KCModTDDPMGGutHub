//
//  PMGControllersTest.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 2/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PMGSimpleViewController.h"
#import "PMGWalletTableViewController.h"
#import "PMGWallet.h"
#import "PMGBroker.h"

@interface PMGControllersTest : XCTestCase

@property (nonatomic, strong) PMGSimpleViewController *simpleVC;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) PMGWalletTableViewController *walletVC;
@property (nonatomic, strong) PMGWallet *wallet;
@property (nonatomic, strong) PMGBroker *broker;

@end

@implementation PMGControllersTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.simpleVC = [[PMGSimpleViewController alloc] initWithNibName: nil bundle: nil];
    self.button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.button setTitle: @"Hola" forState: UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame: CGRectZero];
    self.simpleVC.displayLabel = self.label;
    
    self.wallet = [[PMGWallet alloc] initWithAmount: [NSNumber numberWithInt: 1] currency: @"USD"];
    [self.wallet plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 2]]];
    [self.wallet plus: [PMGMoney euroWithAmount: [NSNumber numberWithInt: 1]]];
    self.broker = [PMGBroker new];
    
    self.walletVC = [[PMGWalletTableViewController alloc] initWithModel: self.wallet broker: self.broker];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    // lo destruimos
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
    self.broker = nil;
    self.walletVC = nil;
}

-(void) testThatTextOnLabelIsEqualToTextOnButton {
    
    // mandamos el mensaje
    [self.simpleVC displayText: self.button];
    
    //comprobamos que etiqueta y botón tienen el mismo texto
    XCTAssertEqualObjects(self.button.titleLabel.text, self.label.text, @"Button and label should have the same text");
}

-(void) testThatTableHashOnSection {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    NSInteger sections = [self.walletVC numberOfSectionsInTableView: nil];
#pragma clang diagnostic pop
    XCTAssertEqual(sections, [self.wallet currencyCounts] + 1, @"");
    
}

//-(void) testThanNumberOfCellsIsNumberOfMoneysPlusOne {
//    
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wnonnull"
//    XCTAssertEqual(self.wallet.moneysCount + 1,
//                   [self.walletVC tableView: nil numberOfRowsInSection: 0],
//                   @"Number of cells is the number of moneys plus 1 (the total)");
//#pragma clang diagnostic pop
//}

// Test de la práctica
// Si hay n divisas en el modelo, el dataSource devuelve n + 1 secciones
-(void) testThatForNCurrenciesThenMustHaveNPlusOneSections {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    XCTAssertEqual([self.wallet currencyCounts] + 1, [self.walletVC numberOfSectionsInTableView: nil], @"Number of cells is the number of moneys plus 1 (the total)");
#pragma clang diagnostic pop

}

//Si hay n moneys en una divisa, el data source debe de devolver n + 1 celdas para esa sección
-(void) testThatNMoneysForCurrencyThenHaveNPlusOneCellsForSection {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    NSInteger indexCurrency = 0;
    NSMutableArray *currencies = [self.wallet getCurrencies];
    for (NSString *currency in currencies) {
        XCTAssertEqual([[self.wallet moneysForCurrency: currency] count] + 1, [self.walletVC tableView: nil numberOfRowsInSection: indexCurrency], @"Number of cells is the number of moneys plus 1 (the total)");
        indexCurrency++;
    }
#pragma clang diagnostic pop
    
}


@end

































