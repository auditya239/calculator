//
//  PViewController.m
//  calculator
//
//  Created by Aditya on 10/09/14.
//  Copyright (c) 2014 Zemoso. All rights reserved.
//

#import "PViewController.h"

@interface PViewController ()
@property (nonatomic, strong) NSString *equationString;
@property (nonatomic, strong) NSString *evalString;
@property (nonatomic) int numOfUnclosedBrackets;
@end

@implementation PViewController{
    NSArray *funcCharArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    funcCharArray = [[NSArray alloc] initWithObjects:@"+",@"-",@"x",@"/", nil];
    _equationString = @"";
    _evalString = @"";
    _numOfUnclosedBrackets = 0;
    [self paintTheButtons];
}

-(void)paintTheButtons{
    for (UIButton* i in _AllButtonsCollection) {
        [i addTarget:self action:@selector(ButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [[i layer] setCornerRadius:30];
        [[i layer] setBorderWidth:1.0];
        [[i layer] setBorderColor:[[UIColor blackColor] CGColor]];
        [i setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    for (UIButton* i in _NumberButtonsCollection) {
        [i setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        i.backgroundColor = [UIColor whiteColor];
    }
    for (UIButton* i in _FunctionButtonsCollection) {
        i.backgroundColor = [UIColor darkGrayColor];
    }
    _equalsButton.backgroundColor = [UIColor orangeColor];
    _CButton.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calculateEquation{
    _ValueLabel.text = @"Logic NaN";
}

-(BOOL)checkIfValidEquation{
    BOOL isValid = TRUE;
    if ([funcCharArray containsObject:[_equationString substringFromIndex:([_equationString length] - 1)]]) {
        isValid = FALSE;
        [[[UIAlertView alloc] initWithTitle:@"Not a valid equation" message:@"Please enter a valid equation" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    return isValid;
}

- (IBAction)ButtonTouched:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *btnString = button.titleLabel.text;
    if ([btnString isEqualToString:@"="]) {
        if (![self checkIfValidEquation]) {
            return;
        }
        [self calculateEquation];
        _equationString = @"";
        if (![_ValueLabel.text isEqualToString:@"NaN"]) {
            _equationString = _ValueLabel.text;
        }
        return;
    }
    if ([btnString isEqualToString:@"C"]) {
        _equationString = @"";
        _EquationLabel.text = @"";
        return;
    }
    else{
        if ([btnString isEqualToString:@"+/-"]) {
            if (![_equationString hasPrefix:@"-"]) {
                _equationString = [NSString stringWithFormat:@"-(%@)", _equationString];
            }
            else{
                _equationString = [_equationString substringWithRange:NSMakeRange(2, [_equationString length]-3)];
            }
        }
        else if([btnString isEqualToString:@"(  )"]){
            
        }
        else if([btnString isEqualToString:@"⌫"]){
            if (_equationString.length > 0) {
                _equationString = [_equationString substringWithRange:NSMakeRange(0, [_equationString length]-1)];
            }
        }
        else if ([funcCharArray containsObject:btnString]){
            if (_equationString.length == 0) {
                return;
            }
            if ([funcCharArray containsObject:[_equationString substringFromIndex:([_equationString length] - 1)]]) {
                if (![btnString isEqualToString:[_equationString substringFromIndex:([_equationString length] - 1)]]) {
                    _equationString = [NSString stringWithFormat:@"%@%@", [_equationString substringWithRange:NSMakeRange(0, [_equationString length]-1)], btnString];
                }
                else
                    return;
            }
            else
                _equationString = [NSString stringWithFormat:@"%@%@", _equationString, btnString];
        }
        else{
            _equationString = [NSString stringWithFormat:@"%@%@", _equationString, btnString];
        }
        _EquationLabel.text = _equationString;
        _ValueLabel.text = @"";
        return;
    }
}

@end
