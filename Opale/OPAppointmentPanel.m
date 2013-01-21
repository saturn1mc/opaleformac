//
//  OPAppointmentPanel.m
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPAppointmentPanel.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"
#import "OPPatient.h"
#import "OPAppointment.h"

@implementation OPAppointmentPanel

@dynamic locked, patient;
@synthesize  patients, parent, switchLockButton, validateButton, cancelButton, patientComboBox, dayPicker, startPicker, endPicker, detailsText;

-(void)awakeFromNib{
    [dayPicker setDateValue:[NSDate date]];
    patients = [[NSMutableArray alloc] init];
    [self reloadPatients];
}


-(BOOL)locked{
    return locked;
}

-(void)setLocked:(BOOL)lock{
    
    if(lock){
        [switchLockButton setImage:[NSImage imageNamed:@"NSLockLockedTemplate"]];
    }
    else{
        [switchLockButton setImage:[NSImage imageNamed:@"NSLockUnlockedTemplate"]];
    }
    
    [validateButton setHidden:lock];
    [validateButton setEnabled:!lock];
    [cancelButton setHidden:lock];
    [cancelButton setEnabled:!lock];
    
    [patientComboBox setSelectable:!lock];
    [patientComboBox setEditable:!lock];
    [patientComboBox setEnabled:!lock];
    
    [dayPicker setEnabled:!lock];
    [startPicker setEnabled:!lock];
    [endPicker setEnabled:!lock];
    
    [detailsText setEditable:!lock];
    [detailsText setSelectable:!lock];
    
    locked = lock;
}

-(OPPatient*)getPatient{
    return patient;
}

-(void)setPatient:(OPPatient *)nPatient{
    patient = nPatient;
    [patientComboBox setStringValue:[NSString stringWithFormat:@"%@ %@", nPatient.lastName, nPatient.firstName]];
}

-(IBAction)switchLock:(id)sender{
    [self setLocked:!locked];
}

-(IBAction)exitPanel:(id)sender{
    
    if(sender == validateButton) {
        if(patient){
            NSCalendar* calendar = [NSCalendar currentCalendar];
            
            NSDateComponents* dayComponents = [calendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[dayPicker dateValue]];
            
            NSDateComponents* startComponents = [calendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[startPicker dateValue]];
            [startComponents setDay:[dayComponents day]];
            [startComponents setMonth:[dayComponents month]];
            [startComponents setYear:[dayComponents year]];
            
            NSDateComponents* endComponents = [calendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[endPicker dateValue]];
            [endComponents setDay:[dayComponents day]];
            [endComponents setMonth:[dayComponents month]];
            [endComponents setYear:[dayComponents year]];
            
            if([[calendar dateFromComponents:startComponents] compare:[NSDate date]] == NSOrderedDescending){
                
                if([[calendar dateFromComponents:startComponents] compare:[calendar dateFromComponents:endComponents]] == NSOrderedAscending){
                    
                    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
                    NSManagedObjectContext* managedObjectContext = [appDelegate managedObjectContext];
                    
                    OPAppointment* nAppointment = [NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:managedObjectContext];
                    
                    nAppointment.patient = patient;
                    nAppointment.details = [[NSString alloc] initWithString:[detailsText string]];
                    nAppointment.start = [calendar dateFromComponents:startComponents];
                    nAppointment.end = [calendar dateFromComponents:endComponents];
                    
                    [appDelegate saveAction:self];
                }
                else{
                    NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Les heures de début et de fin sont incohérentes"];
                    [alert beginSheetModalForWindow:self modalDelegate:self didEndSelector:nil contextInfo:nil];
                }
            }
            else{
                NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"La date de début sélectionnée est dépassée"];
                [alert beginSheetModalForWindow:self modalDelegate:self didEndSelector:nil contextInfo:nil];
            }
        }
        else{
            NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Aucun patient n'est sélectionné"];
            [alert beginSheetModalForWindow:self modalDelegate:self didEndSelector:nil contextInfo:nil];
        }
    }
    else{
        [NSApp endSheet:self];
        [self orderOut:self];
    }
}

#pragma mark - Combobox datasource and delegate methods
-(void)reloadPatients{
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    NSManagedObjectContext* managedObjectContext = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Patient" inManagedObjectContext:managedObjectContext]];
    [request setIncludesSubentities:NO];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error = nil;
    NSArray* results = [managedObjectContext executeFetchRequest:request error:&error];
    
    if(results != nil) {
        [patients removeAllObjects];
        [patients addObjectsFromArray:results];
    }
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    
    [self reloadPatients];
    
    if(patients){
        return [patients count];
    }
    else{
        return 0;
    }
    
    
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index{
    OPPatient* patientAtIndex = (OPPatient*)[patients objectAtIndex:index];
    return [NSString stringWithFormat:@"%@ %@", patientAtIndex.lastName, patientAtIndex.firstName];
}

- (NSString *)comboBox:(NSComboBox *)aComboBox completedString:(NSString *)string{
    for(OPPatient* testedPatient in patients){
        if([[testedPatient.lastName uppercaseString] hasPrefix:[string uppercaseString]]){
            patient = testedPatient;
            return [NSString stringWithFormat:@"%@ %@", testedPatient.lastName, testedPatient.firstName];
        }
        
        if([[testedPatient.lastName uppercaseString] compare:[string uppercaseString]] != NSOrderedAscending){
            patient = nil;
            break;
        }
    }
    
    return 0;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification{
    patient = [patients objectAtIndex:[patientComboBox indexOfSelectedItem]];
}


@end