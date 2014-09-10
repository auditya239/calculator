//
//  PViewController.h
//  calculator
//
//  Created by Aditya on 10/09/14.
//  Copyright (c) 2014 Zemoso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *EquationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ValueLabel;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *AllButtonsCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *NumberButtonsCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *FunctionButtonsCollection;
@property (weak, nonatomic) IBOutlet UIButton *equalsButton;
@property (weak, nonatomic) IBOutlet UIButton *CButton;

@end
