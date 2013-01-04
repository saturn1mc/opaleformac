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

@implementation OPNewPatientView

@synthesize cellFirstName, cellLastName, birthdayPicker, matrixSex, cellTel1, cellTel2, cellAddress, cellTown, cellPostalCode, cellCountry;

-(IBAction)validatePatient:(id)sender{

    //TODO verify inputs
    
    NSString* sex = [[NSString alloc] init];
    
    if([matrixSex selectedRow] == 0){
        sex = @"Homme";
    }
    else{
        sex = @"Femme";
    }
    
    OPPatient* nPatient = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:[self managedObjectContext]];
    
    nPatient.firstName = [cellFirstName stringValue];
    nPatient.lastName = [cellLastName stringValue];
    nPatient.birthday = [birthdayPicker dateValue];
    nPatient.sex = sex; 
    nPatient.address = [cellAddress stringValue];
    nPatient.town = [cellTown stringValue];
    nPatient.postalCode = [cellPostalCode stringValue];
    nPatient.country = [cellCountry stringValue];
    nPatient.tel1 = [cellTel1 stringValue];
    nPatient.tel2 = [cellTel2 stringValue];
    
    [self saveAction];
    
    [parent showPatientViewFor:nPatient];
}

@end
