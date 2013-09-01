//
//  OPProfessionalView.m
//  Opale
//
//  Created by Camille on 29/06/13.
//
//

#import "OPProfessionalView.h"
#import "OPProfessional.h"
#import "OPTownsDataSource.h"
#import "OPMainWindow.h"

@implementation OPProfessionalView

@synthesize professional, switchLockButton, editableObjects, modified, cellFirstName, cellLastName, cellSpeciality, cellTel, cellAddress, cellTown, postalCodeComboBox, cellCountry;

- (void)awakeFromNib{
    
    modified = NO;
    
    [postalCodeComboBox setDataSource:[OPTownsDataSource getInstance]];
    
    //Editable objects
    editableObjects = [[NSMutableArray alloc] init];
    
    [self addEditableObject:cellFirstName];
    [self addEditableObject:cellLastName];
    [self addEditableObject:cellSpeciality];
    [self addEditableObject:cellTel];
    [self addEditableObject:cellAddress];
    [self addEditableObject:cellTown];
    [self addEditableObject:postalCodeComboBox];
    [self addEditableObject:cellCountry];
}

-(void)controlTextDidChange:(NSNotification *)obj{
    modified = YES;
    
    NSString* town = [[OPTownsDataSource getInstance] getTownForPostalCode:[postalCodeComboBox stringValue]];
    
    if(town){
        [cellTown setStringValue:town];
    }
    else{
        [cellTown setStringValue:@""];
    }
}

-(IBAction)switchLock:(id)sender{
    if(locked){
        [self setLocked:NO];
    }
    else{
        [self setLocked:YES];
        [self saveProfessional:self];
    }
}

-(BOOL)locked{
    return locked;
}

-(void)setLocked:(BOOL)lock{
    [self setEditableObjectsState:lock];
    
    if(lock){
        [switchLockButton setImage:[NSImage imageNamed:@"NSLockLockedTemplate"]];
        [switchLockButton setTitle:@"Modifier la fiche"];
    }
    else{
        [switchLockButton setImage:[NSImage imageNamed:@"NSLockUnlockedTemplate"]];
        [switchLockButton setTitle:@"Sauver la fiche"];
    }
    
    locked = lock;
}

-(void)addEditableObject:(id)object{
    if(object){
        [editableObjects addObject:object];
        
        if([object isKindOfClass:[NSTextField class]] || [object isKindOfClass:[NSTextView class]]){
            [object setDelegate:self];
        }
    }
}

-(void)setEditableObjectsState:(BOOL)lock{
    
    if(lock){
        [parent makeFirstResponder:nil];
    }
    
    for(id obj in editableObjects){
        if([obj isKindOfClass:[NSFormCell class]]){
            [(NSFormCell*)obj setEditable:!lock];
            [(NSFormCell*)obj setSelectable:!lock];
            [(NSFormCell*)obj setBezeled:!lock];
        }
        
        else if([obj isKindOfClass:[NSDatePicker class]]){
            [(NSDatePicker*)obj setEnabled:!lock];
        }
        
        
        else if([obj isKindOfClass:[NSMatrix class]]){
            [(NSMatrix*)obj setEnabled:!lock];
        }
        
        else if([obj isKindOfClass:[NSComboBox class]]){
            [(NSComboBox*)obj setEditable:!lock];
            [(NSComboBox*)obj setSelectable:!lock];
            [(NSComboBox*)obj setEnabled:!lock];
        }
        
        else if([obj isKindOfClass:[NSTextField class]]){
            [(NSTextField*)obj setBezeled:!lock];
            [(NSTextField*)obj setEditable:!lock];
            [(NSTextField*)obj setSelectable:!lock];
        }
        
        else if([obj isKindOfClass:[NSTextView class]]){
            [(NSTextView*)obj setEditable:!lock];
            [(NSTextView*)obj setSelectable:!lock];
        }
        
        else if([obj isKindOfClass:[NSButton class]]){
            [(NSButton*)obj setEnabled:!lock];
        }
    }
}

-(void)textDidChange:(NSNotification *)notification{
    modified = YES;
}

-(void)loadProfessional:(OPProfessional *)professionalToLoad{
    
    professional = professionalToLoad;
    
    modified = NO;
    
    //General tab
    [OPView initFormCell:cellFirstName withString:professional.firstName];
    [OPView initFormCell:cellLastName withString:professional.lastName];
    [OPView initFormCell:cellSpeciality withString:professional.speciality];
    [OPView initFormCell:cellTel withString:professional.tel];
    [OPView initFormCell:cellAddress withString:professional.address];
    [OPView initFormCell:cellTown withString:professional.town];
    [OPView initComboBox:postalCodeComboBox withString:professional.postalCode];
    [OPView initFormCell:cellCountry withString:professional.country];
    
}

#pragma mark - Saving modifications

-(void)applyModifications{
    professional.firstName = [[NSString alloc] initWithString:[cellFirstName stringValue]];
    professional.lastName = [[NSString alloc] initWithString:[cellLastName stringValue]];
    professional.speciality = [[NSString alloc] initWithString:[cellSpeciality stringValue]];
    professional.tel = [[NSString alloc] initWithString:[cellTel stringValue]];
    professional.address = [[NSString alloc] initWithString:[cellAddress stringValue]];
    professional.town = [[NSString alloc] initWithString:[cellTown stringValue]];
    professional.postalCode = [[NSString alloc] initWithString:[postalCodeComboBox stringValue]];
    professional.country = [[NSString alloc] initWithString:[cellCountry stringValue]];
}

-(IBAction)saveProfessional:(id)sender{
    modified = NO;
    [self applyModifications];
    [self saveAction];
}

-(BOOL)quitView{
    if(modified){
        NSAlert *alert = [NSAlert alertWithMessageText:@"Sauvegarder ?" defaultButton:@"Oui" alternateButton:@"Non" otherButton:nil informativeTextWithFormat:@"La fiche du professionnel a été modifiée. Sauvegarder ?"];
        [alert setAlertStyle:NSCriticalAlertStyle];
        
        if([alert runModal] == NSAlertDefaultReturn){
            [self saveProfessional:self];
        }
    }
    
    return YES;
}

@end
