//
//  OPNewPatientView.m
//  Opale
//
//  Created by Camille on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPNewPatientView.h"
#import "OPMainWindow.h"
#import "OPAdultMalePatientView.h"
#import "OPPatient.h"
#import "OPTownsDataSource.h"

@implementation OPNewPatientView

@synthesize cellFirstName, errorImageFirstName, cellLastName, errorImageLastName, birthdayPicker, matrixSex, cellTel1, cellTel2, cellAddress, cellTown, postalCodeComboBox, cellCountry;

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [postalCodeComboBox setDataSource:[OPTownsDataSource getInstance]];
}

-(void)controlTextDidChange:(NSNotification *)obj{
    NSString* town = [[OPTownsDataSource getInstance] getTownForPostalCode:[postalCodeComboBox stringValue]];
    if(town){
        [cellTown setStringValue:town];
    }
}

-(IBAction)validatePatient:(id)sender{
    
    BOOL error = NO;
    
    if([[cellLastName stringValue] length] > 0){
        [errorImageLastName setHidden:YES];
    }
    else{
        [errorImageLastName setHidden:NO];
        error = YES;
    }
    
    if([[cellFirstName stringValue] length] > 0){
        [errorImageFirstName setHidden:YES];
    }
    else{
        [errorImageFirstName setHidden:NO];
        error = YES;
    }
    
    
    if(error){
        NSAlert *alert = [NSAlert alertWithMessageText:@"Création impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Veuillez renseigner toutes les données obligatoire"];
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    else{
        NSString* sex;
        
        if([matrixSex selectedRow] == 0){
            sex = @"Masculin";
        }
        else{
            sex = @"Feminin";
        }
        
        
        OPPatient* nPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[self managedObjectContext]];
        
        nPatient.firstName = [cellFirstName stringValue];
        nPatient.lastName = [cellLastName stringValue];
        nPatient.birthday = [birthdayPicker dateValue];
        nPatient.sex = sex;
        nPatient.address = [cellAddress stringValue];
        nPatient.town = [cellTown stringValue];
        nPatient.postalCode = [postalCodeComboBox stringValue];
        nPatient.country = [cellCountry stringValue];
        nPatient.tel1 = [cellTel1 stringValue];
        nPatient.tel2 = [cellTel2 stringValue];
        
        [self saveAction];
        
        [parent showPatientViewFor:nPatient withLockState:NO];
    }
}

@end
