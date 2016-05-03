# Wallet

This repo contains a Objective-C project as a practical work for the TDD module.

This project represents a wallet that can be used to perform operations (sum and convertion) using different currencies. You can find a example below:

The operation to resolve is:

$2 + $4 + $5 + $3 + €15 + €10 + €100 = €132 (rate $2:€1).

The result screen in your iPhone should be the following:

`PMGWallet *wallet = [[PMGWallet alloc] initWithAmount: [NSNumber numberWithInt: 2] currency: @"USD"];
[wallet plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 4]]];
[wallet plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 5]]];
[wallet plus: [PMGMoney euroWithAmount: [NSNumber numberWithInt: 15]]];
[wallet plus: [PMGMoney euroWithAmount: [NSNumber numberWithInt: 10]]];
[wallet plus: [PMGMoney dollarWithAmount: [NSNumber numberWithInt: 3]]];
[wallet plus: [PMGMoney euroWithAmount: [NSNumber numberWithInt: 100]]];`

PMGBroker *broker = [PMGBroker new];
[broker addRate: 2 fromCurrency: @"EUR" toCurrency: @"USD"];

[http://i.imgur.com/xxKgpx0.png?1
