//
//  PMGWalletTableViewController.m
//  Wallet
//
//  Created by Pedro Martin Gomez on 2/5/16.
//  Copyright © 2016 Pedro Martin Gomez. All rights reserved.
//

#import "PMGWalletTableViewController.h"
#import "PMGWallet.h"
#import "PMGBroker.h"

@interface PMGWalletTableViewController ()

@property (nonatomic, strong) PMGWallet *model;
@property (nonatomic, strong) PMGBroker *broker;
@property (nonatomic, strong) NSString *cellId;

@end

@implementation PMGWalletTableViewController

-(id) initWithModel: (PMGWallet *) model broker:(PMGBroker *) broker {
    
    if (self = [super initWithStyle: UITableViewStylePlain]) {
        _model = model;
        _broker = broker;
        _cellId = @"cellID";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [self.wallet moneyTypes] + 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([self.wallet moneyTypes] == section){
//        return 1;
//    }
//    return [self.wallet moneysCountFromType:section] + 1;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if ([self.wallet moneyTypes] == section){
//        return @"Total Wallet";
//    }
//    return [self.wallet moneyTypeForIndex:section];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.model currencyCounts] + 1; // one per each currency plus "Total" section
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.model currencyCounts] == section){
        return 1;
    }
    return [self.model moneysForCurrencyCount: [self.model currencyAtIndex: section]] + 1; // one per each money plus "Subtotal per currency" section
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.model currencyCounts] == section){
        return @"Total Wallet";
    }
    return [self.model currencyAtIndex: section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Creating the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: self.cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: self.cellId];
    }
    
    PMGMoney *money;
    NSString *cellValue;
    
    if ([self.model currencyCounts] == indexPath.section) {
        
        money = [self.model reduceToCurrency: @"EUR" withBroker: self.broker];
        cellValue = [NSString stringWithFormat:@"Total %@ %@ rate USD-EUR (%@:1)",
                     money.currency,
                     [money.amount stringValue],
                     [[self.broker takeRate: @"EUR" toCurrency: @"USD"] stringValue]];
    }
    else
    {
        NSString *currentCurrency = [self.model currencyAtIndex: indexPath.section];
        if ([self.model moneysForCurrencyCount: currentCurrency] == indexPath.row) {
            
            cellValue = [NSString stringWithFormat:@"SubTotal %@ %ld", currentCurrency, (long)[self.model calculateSumForCurrency: currentCurrency]];
            
        } else {
            money = [self.model takeMoney: currentCurrency indexAt: indexPath.row];
            cellValue = [money.amount stringValue];
        }
        
    }

    cell.textLabel.text = cellValue;
    
    return cell;
}


@end


























