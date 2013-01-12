//
//  OPExistingPatientView.m
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPExistingPatientView.h"
#import "OPMainWindow.h"
#import "OPScanningView.h"
#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPDocument.h"
#import "OPMail.h"

@implementation OPExistingPatientView

@dynamic locked;

@synthesize patient, sortedConsultations, editableObjects, switchLockButton, addressedByBox, cellFirstName, cellLastName, cellBirthday, cellSex, cellTel1, cellTel2, cellAddress, cellTown, cellPostalCode, cellCountry, generalComments, previousHistoryComments, familyHistory, medicalHistory,traumaticHistory, surgicalHistory, entAndOphtalmologicSphere, dentalSphere, digestiveSphere,urinarySphere, deleteConsultationButton, consultationsTable, colDate, colMotives, deleteDocumentButton, documentsTable, colDocumentTitle, colDocumentFilePath, deleteMailButton, mailsTable, colMailName, colMailFilePath;

- (void)awakeFromNib{
    //Editable objects
    editableObjects = [[NSMutableArray alloc] init];
    
    [self addEditableObject:addressedByBox];
    [self addEditableObject:cellFirstName];
    [self addEditableObject:cellLastName];
    [self addEditableObject:cellBirthday];
    [self addEditableObject:cellSex];
    [self addEditableObject:cellTel1];
    [self addEditableObject:cellTel2];
    [self addEditableObject:cellAddress];
    [self addEditableObject:cellTown];
    [self addEditableObject:cellPostalCode];
    [self addEditableObject:cellCountry];
    [self addEditableObject:generalComments];
    [self addEditableObject:previousHistoryComments];
    [self addEditableObject:familyHistory];
    [self addEditableObject:medicalHistory];
    [self addEditableObject:traumaticHistory];
    [self addEditableObject:surgicalHistory];
    [self addEditableObject:entAndOphtalmologicSphere];
    [self addEditableObject:dentalSphere];
    [self addEditableObject:digestiveSphere];
    [self addEditableObject:urinarySphere];
    
    //Consultation tab
    [self addEditableObject:deleteConsultationButton];
    [consultationsTable setDoubleAction:@selector(showConsultation:)];
    sortedConsultations = [[NSMutableArray alloc] init];
    [colDate setIdentifier:@"date"];
    [colMotives setIdentifier:@"motives"];
    
    //Documents tab
    [self addEditableObject:deleteDocumentButton];
    [documentsTable setDoubleAction:@selector(openDocument:)];
    [colDocumentTitle setIdentifier:@"title"];
    [colDocumentFilePath setIdentifier:@"docPath"];
    
    //Mails tab
    [self addEditableObject:deleteMailButton];
    [mailsTable setDoubleAction:@selector(openMail:)];
    [colMailName setIdentifier:@"name"];
    [colMailFilePath setIdentifier:@"path"];
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
    }
}

-(void)setEditableObjectsState:(BOOL)lock{
    for(id obj in editableObjects){
        if([obj isKindOfClass:[NSFormCell class]]){
            [(NSFormCell*)obj setEditable:!lock];
            [(NSFormCell*)obj setSelectable:!lock];
            [(NSFormCell*)obj setBezeled:!lock];
        }
        
        else if([obj isKindOfClass:[NSComboBox class]]){
            [(NSComboBox*)obj setEditable:!lock];
            [(NSComboBox*)obj setSelectable:!lock];
            [(NSComboBox*)obj setEnabled:!lock];
        }
        
        else if([obj isKindOfClass:[NSTextField class]]){
            [(NSTextField*)obj setEditable:!lock];
            [(NSTextField*)obj setSelectable:!lock];
            [(NSTextField*)obj setBezeled:!lock];
            
            if(lock){
                [(NSTextField*)obj setBackgroundColor:[NSColor controlBackgroundColor]];
            }
            else{
                [(NSTextField*)obj setBackgroundColor:[NSColor textBackgroundColor]];
            }
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

-(IBAction)switchLock:(id)sender{
    if(locked){
        [self setLocked:NO];
    }
    else{
        [self setLocked:YES];
        [self savePatient:self];
    }
}

-(void)loadPatient:(OPPatient*)patientToLoad{
    
    patient = patientToLoad;
    
    [OPView initTextField:addressedByBox withString:patient.addressedBy];
    
    //General tab
    [OPView initFormCell:cellFirstName withString:patient.firstName];
    [OPView initFormCell:cellLastName withString:patient.lastName];
    [OPView initFormCell:cellBirthday withDate:patient.birthday];
    [OPView initFormCell:cellSex withString:patient.sex];
    [OPView initFormCell:cellTel1 withString:patient.tel1];
    [OPView initFormCell:cellTel2 withString:patient.tel2];
    [OPView initFormCell:cellAddress withString:patient.address];
    [OPView initFormCell:cellTown withString:patient.town];
    [OPView initFormCell:cellPostalCode withString:patient.postalCode];
    [OPView initFormCell:cellCountry withString:patient.country];
    
    [OPView initTextView:generalComments withString:patient.generalComments];
    
    //History tab
    [OPView initTextView:previousHistoryComments withString:patient.generalComments];
    [OPView initTextView:familyHistory withString:patient.familyHistory];
    [OPView initTextView:medicalHistory withString:patient.medicalHistory];
    [OPView initTextView:traumaticHistory withString:patient.traumaticHistory];
    [OPView initTextView:surgicalHistory withString:patient.surgicalHistory];
    
    //Sphere tab
    [OPView initTextView:entAndOphtalmologicSphere withString:patient.entAndOphtalmologicSphere];
    [OPView initTextView:dentalSphere withString:patient.dentalSphere];
    [OPView initTextView:digestiveSphere withString:patient.digestiveSphere];
    [OPView initTextView:urinarySphere withString:patient.urinarySphere];
    
    [self sortConsultations];
}

#pragma mark - Actions
-(IBAction)scanDocument:(id)sender{
    [[parent scanningView] setPatient:patient];
    [parent showScanningView:self];
}

-(IBAction)importDocument:(id)sender{
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setCanChooseFiles:YES];
    [openPanel setAllowsMultipleSelection:NO];
    
    [openPanel beginSheetModalForWindow:parent completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL* openURL = [[openPanel URLs] objectAtIndex:0];
            NSURL* targetURL = [parent documentDirectoryFor:patient];
            NSString* targetStr = [[NSString alloc] initWithFormat:@"%@/%@", [targetURL path], [openURL lastPathComponent]];
            
            [[NSFileManager defaultManager] copyItemAtPath:[openURL path] toPath:targetStr error:nil];
            
            OPDocument* nDocument = [NSEntityDescription insertNewObjectForEntityForName:@"Document" inManagedObjectContext:[self managedObjectContext]];
            nDocument.patient = patient;
            nDocument.filePath = [[NSString alloc] initWithString:targetStr];
            
            [self saveAction];
            
            [documentsTable reloadData];

        }
    }];
}

-(IBAction)openDocument:(id)sender{
    OPDocument* document = [[patient.documents allObjects] objectAtIndex:documentsTable.clickedRow];
    [parent openDocument:document];
}

-(IBAction)deleteDocument:(id)sender{
    if(documentsTable.numberOfSelectedRows > 0){
        OPDocument* document = [[patient.documents allObjects] objectAtIndex:documentsTable.selectedRow];
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Supprimer le document ?" defaultButton:@"Annuler" alternateButton:@"Oui" otherButton:nil informativeTextWithFormat:@"Le document '%@' sera définitivement supprimé de la base", [[NSURL fileURLWithPath:document.filePath] lastPathComponent] ];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:@selector(docAlertDidEnd:returnCode:contextInfo:) contextInfo:(void*)document];
    }
    else{
        NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Aucun document n'est sélectionné"];
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
}

-(void)docAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    if(returnCode == NSAlertAlternateReturn){
        OPDocument* document = (__bridge OPDocument *)(contextInfo);
        [patient removeDocumentsObject:document];
        
        [[NSFileManager defaultManager] removeItemAtPath:document.filePath error:nil];
        
        [[self managedObjectContext] deleteObject:document];
        [self saveAction];
        
        [documentsTable reloadData];
    }
}

-(void)applyModifications{
    patient.addressedBy = [[NSString alloc] initWithString:[addressedByBox stringValue]];
    patient.firstName = [[NSString alloc] initWithString:[cellFirstName stringValue]];
    patient.lastName = [[NSString alloc] initWithString:[cellLastName stringValue]];
    
    NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setLocale:frLocale];
    patient.birthday = [dateFormatter dateFromString:[cellBirthday stringValue]];
    
    patient.sex = [[NSString alloc] initWithString:[cellSex stringValue]];
    patient.tel1 = [[NSString alloc] initWithString:[cellTel1 stringValue]];
    patient.tel2 = [[NSString alloc] initWithString:[cellTel2 stringValue]];
    patient.address = [[NSString alloc] initWithString:[cellAddress stringValue]];
    patient.town = [[NSString alloc] initWithString:[cellTown stringValue]];
    patient.postalCode = [[NSString alloc] initWithString:[cellPostalCode stringValue]];
    patient.country = [[NSString alloc] initWithString:[cellCountry stringValue]];
    patient.generalComments = [[NSString alloc] initWithString:[generalComments string]];
    patient.previousHistoryComments = [[NSString alloc] initWithString:[previousHistoryComments string]];
    patient.familyHistory = [[NSString alloc] initWithString:[familyHistory string]];
    patient.medicalHistory = [[NSString alloc] initWithString:[medicalHistory string]];
    patient.traumaticHistory = [[NSString alloc] initWithString:[traumaticHistory string]];
    patient.surgicalHistory = [[NSString alloc] initWithString:[surgicalHistory string]];
    patient.entAndOphtalmologicSphere = [[NSString alloc] initWithString:[entAndOphtalmologicSphere string]];
    patient.dentalSphere = [[NSString alloc] initWithString:[dentalSphere string]];
    patient.digestiveSphere = [[NSString alloc] initWithString:[digestiveSphere string]];
    patient.urinarySphere = [[NSString alloc] initWithString:[urinarySphere string]];
}

-(IBAction)savePatient:(id)sender{
    [self applyModifications];
    [self saveAction];
}

#pragma mark - Consultations management

-(void)sortConsultations{
    NSArray* consultations = [patient.consultations allObjects];
    
    sortedConsultations = [consultations sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        OPConsultation* consultation1 = (OPConsultation*) obj1;
        OPConsultation* consultation2 = (OPConsultation*) obj2;
        
        return [consultation1.date compare:consultation2.date];
    }];
    
    [consultationsTable reloadData];
}


-(IBAction)newConsultation:(id)sender{
    OPConsultation* nConsultation = [NSEntityDescription insertNewObjectForEntityForName:@"Consultation" inManagedObjectContext:[self managedObjectContext]];
    
    nConsultation.patient = patient;
    nConsultation.date = [NSDate date];
    
    [self saveAction];
    
    [parent showConsultationViewFor:nConsultation];
    
    [self sortConsultations];
    
    [consultationsTable reloadData];
}

-(IBAction)showConsultation:(id)sender{
    OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:consultationsTable.selectedRow];
    [parent showConsultationViewFor:consultation];
}

-(IBAction)deleteConsultation:(id)sender{
    if(consultationsTable.numberOfSelectedRows > 0){
        OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:consultationsTable.selectedRow];
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Supprimer la consultation ?" defaultButton:@"Annuler" alternateButton:@"Oui" otherButton:nil informativeTextWithFormat:@"La consultation sélectionnée sera définitivement supprimée de la base"];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:@selector(docAlertDidEnd:returnCode:contextInfo:) contextInfo:(void*)consultation];
    }
    else{
        NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Aucune consultation n'est sélectionnée"];
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
}

-(void)consultAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    if(returnCode == NSAlertAlternateReturn){
        OPConsultation* consultation = (__bridge OPConsultation *)(contextInfo);
        [patient removeConsultationsObject:consultation];
        
        [[self managedObjectContext] deleteObject:consultation];
        [self saveAction];
        
        [consultationsTable reloadData];
    }
}

#pragma mark - Mails

-(IBAction)createNewMail:(id)sender{
    NSSavePanel* savePanel = [NSSavePanel savePanel];
    [savePanel setTitle:@"Enregistrer la lettre sous"];
    
    NSArray* allowedFileTypes = [[NSArray alloc] initWithObjects:@"docx", nil];
    [savePanel setAllowedFileTypes:allowedFileTypes];
    [savePanel setDirectoryURL:[parent mailDirectoryFor:patient]];
    
    [savePanel beginSheetModalForWindow:parent completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSString* targetPath = [[savePanel URL] path];
            NSString* templatePath = [[NSBundle mainBundle] pathForResource:@"Mail_Template" ofType:@"docx"];
            [[NSFileManager defaultManager] copyItemAtPath:templatePath toPath:targetPath error:nil];
            
            OPMail* nMail = [NSEntityDescription insertNewObjectForEntityForName:@"Mail" inManagedObjectContext:[self managedObjectContext]];
            nMail.patient = patient;
            nMail.filePath = [[NSString alloc] initWithString:targetPath];
            
            [self saveAction];
            
            [mailsTable reloadData];
            [parent openMail:nMail];
        }
    }];
}

-(IBAction)importMail:(id)sender{
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowedFileTypes:[NSArray arrayWithObjects:@"docx", @"doc", nil]];
    [openPanel setCanChooseFiles:YES];
    [openPanel setAllowsMultipleSelection:NO];
    
    [openPanel beginSheetModalForWindow:parent completionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL* openURL = [[openPanel URLs] objectAtIndex:0];
            NSURL* targetURL = [parent mailDirectoryFor:patient];
            NSString* targetStr = [[NSString alloc] initWithFormat:@"%@/%@", [targetURL path], [openURL lastPathComponent]];
            
            [[NSFileManager defaultManager] copyItemAtPath:[openURL path] toPath:targetStr error:nil];
            
            OPDocument* nMail = [NSEntityDescription insertNewObjectForEntityForName:@"Mail" inManagedObjectContext:[self managedObjectContext]];
            nMail.patient = patient;
            nMail.filePath = [[NSString alloc] initWithString:targetStr];
            
            [self saveAction];
            
            [mailsTable reloadData];
        }
    }];

}

-(IBAction)openMail:(id)sender{
    OPMail* mail = [[patient.mails allObjects] objectAtIndex:mailsTable.clickedRow];
    [parent openMail:mail];
}

-(IBAction)deleteMail:(id)sender{
    if(consultationsTable.numberOfSelectedRows > 0){
        OPMail* mail = (OPMail*)[[patient.mails allObjects] objectAtIndex:mailsTable.selectedRow];
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Supprimer le courrier ?" defaultButton:@"Annuler" alternateButton:@"Oui" otherButton:nil informativeTextWithFormat:@"Le courrier '%@' sera définitivement supprimé de la base", [[NSURL fileURLWithPath:mail.filePath] lastPathComponent] ];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:@selector(mailAlertDidEnd:returnCode:contextInfo:) contextInfo:(void*)mail];
    }
    else{
        NSAlert *alert = [NSAlert alertWithMessageText:@"Action impossible" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"Aucun courrier n'est sélectionné"];
        [alert beginSheetModalForWindow:parent modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
}

-(void)mailAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    if(returnCode == NSAlertAlternateReturn){
        OPMail* mail = (__bridge OPMail *)(contextInfo);
        [patient removeMailsObject:mail];
        
        [[NSFileManager defaultManager] removeItemAtPath:mail.filePath error:nil];
        
        [[self managedObjectContext] deleteObject:mail];
        [self saveAction];
        
        [mailsTable reloadData];
    }
}
#pragma mark - Result table content management

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count=0;
    
    if(tableView == consultationsTable){
        if (sortedConsultations){
            count = [sortedConsultations count];
        }
    }
    else if(tableView == documentsTable){
        count = [[patient.documents allObjects] count];
    }
    else if(tableView == mailsTable){
        count = [[patient.mails allObjects] count];
    }
    
    return count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSString* value = [[NSString alloc] init];
    
    if(tableView == consultationsTable){
        
        OPConsultation* consultation = (OPConsultation*)[sortedConsultations objectAtIndex:row];
        
        if([[tableColumn identifier] isEqualToString:colDate.identifier]){
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            value = [dateFormatter stringFromDate:consultation.date];
        }
        else if([[tableColumn identifier] isEqualToString:colMotives.identifier]){
            if(consultation.motives){
                value = [[NSString alloc] initWithString:consultation.motives];
            }
            else{
                value = @"";
            }
        }
    }
    else if(tableView == documentsTable){
        
        OPDocument* document = (OPDocument*)[[patient.documents allObjects] objectAtIndex:row];
        
        if([[tableColumn identifier] isEqualToString:colDocumentTitle.identifier]){
            NSURL* documentURL = [NSURL fileURLWithPath:document.filePath];
            value = [[documentURL lastPathComponent] stringByDeletingPathExtension];
        }
        else if ([[tableColumn identifier] isEqualToString:colDocumentFilePath.identifier]){
            value = document.filePath;
        }
    }
    else if(tableView == mailsTable){
        OPMail* mail = (OPMail*)[[patient.mails allObjects]objectAtIndex:row];
        NSURL* mailURL = [NSURL fileURLWithPath:mail.filePath];
        
        if([tableColumn.identifier isEqualToString:colMailName.identifier]){
            value = [[mailURL lastPathComponent] stringByDeletingPathExtension];
        }
        else if([tableColumn.identifier isEqualToString:colMailFilePath.identifier]){
            value = [mailURL path];
        }
    }
    
    return value;
}

@end
