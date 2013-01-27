//
//  OPEditAppointmentView.m
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPEditAppointmentView.h"
#import "OPMainWindow.h"
#import "OPCalendarView.h"
#import "OPAppDelegate.h"
#import "OPPatient.h"
#import "OPAppointment.h"
#import "OPAppointmentPanel.h"

@implementation OPEditAppointmentView

@dynamic locked, patient, appointment;
@synthesize  patients, appointmentPopOver, appointmentPanel, switchLockButton, validateButton, cancelButton, patientComboBox, dayPicker, startPicker, endPicker, detailsText;

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
    
    if(nPatient){
        [patientComboBox setStringValue:[NSString stringWithFormat:@"%@ %@", nPatient.lastName, nPatient.firstName]];
    }
    else{
        [patientComboBox deselectItemAtIndex:[patientComboBox indexOfSelectedItem]];
    }
}

-(OPAppointment*)getAppointment{
    return appointment;
}

-(void)setAppointment:(OPAppointment *)nAppointment{
    
    appointment = nAppointment;
    
    if(nAppointment){
        [dayPicker setDateValue:nAppointment.start];
        [startPicker setDateValue:nAppointment.start];
        [endPicker setDateValue:nAppointment.end];
        [detailsText setString:nAppointment.details];
        
        [self setPatient:nAppointment.patient];
    }
}

-(IBAction)switchLock:(id)sender{
    [self setLocked:!locked];
}

-(IBAction)checkInputs:(id)sender{
    
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
                    
                    if(appointment == nil){ //New appointment
                        OPAppointment* nAppointment = [NSEntityDescription insertNewObjectForEntityForName:@"Appointment" inManagedObjectContext:managedObjectContext];
                        
                        appointment = nAppointment;
                    }
                    
                    appointment.patient = patient;
                    appointment.details = [[NSString alloc] initWithString:[detailsText string]];
                    appointment.start = [calendar dateFromComponents:startComponents];
                    appointment.end = [calendar dateFromComponents:endComponents];
                    
                    [appDelegate saveAction:self];
                    
                    [self closePanel:self];
                }
                else{
                    NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Les heures de début et de fin sont incohérentes"];
                    [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
                }
            }
            else{
                NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"La date de début sélectionnée est dépassée"];
                [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
            }
        }
        else{
            NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Aucun patient n'est sélectionné"];
            [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
        }
    }
    else{
        [self closePanel:self];
    }
}

-(IBAction)closePanel:(id)sender{
    if([appointmentPopOver isShown]){
        [appointmentPopOver performClose:self];
    }
    
    if(appointmentPanel){
        [NSApp endSheet:appointmentPanel];
        [appointmentPanel orderOut:appointmentPanel];
    }
    
    [[parent calendarView] refreshView];
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
