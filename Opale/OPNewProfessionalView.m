//
//  OPNewProfessionalView.m
//  Opale
//
//  Created by Camille on 29/06/13.
//
//

#import "OPNewProfessionalView.h"
#import "OPMainWindow.h"
#import "OPProfessional.h"
#import "OPTownsDataSource.h"

@implementation OPNewProfessionalView

@synthesize cellFirstName, errorImageFirstName, cellLastName, errorImageLastName, cellSpeciality, cellTel, cellAddress, cellTown, postalCodeComboBox, cellCountry;

-(void)awakeFromNib{
    [super awakeFromNib];
    [postalCodeComboBox setDataSource:[OPTownsDataSource getInstance]];
}

-(void)controlTextDidChange:(NSNotification *)obj{
    NSString* town = [[OPTownsDataSource getInstance] getTownForPostalCode:[postalCodeComboBox stringValue]];
    
    if(town){
        [cellTown setStringValue:town];
    }
    else{
        [cellTown setStringValue:@""];
    }
}

-(IBAction)validateProfessional:(id)sender{
    
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
        OPProfessional* nProfessional = [NSEntityDescription insertNewObjectForEntityForName:@"Professional" inManagedObjectContext:[self managedObjectContext]];
        
        nProfessional.firstName = [cellFirstName stringValue];
        nProfessional.lastName = [cellLastName stringValue];
        nProfessional.speciality = [cellSpeciality stringValue];
        nProfessional.address = [cellAddress stringValue];
        nProfessional.town = [cellTown stringValue];
        nProfessional.postalCode = [postalCodeComboBox stringValue];
        nProfessional.country = [cellCountry stringValue];
        nProfessional.tel = [cellTel stringValue];
        
        [self saveAction];
        
        [parent showProfessionalViewFor:nProfessional withLockState:NO];
    }
}

@end
