//
//  OPExistingPatientView.h
//  Opale
//
//  Created by Camille Maurice on 25/06/12.
//  Copyright (c) 2012 CSC. All rights reserved.
//

#import "OPView.h"

@class OPPatient, OPAppointmentPanel;

@interface OPExistingPatientView : OPView <NSTableViewDelegate, NSTableViewDataSource>{
    OPPatient* patient;
    NSArray* sortedConsultations;
    
    BOOL locked;
    NSMutableArray* editableObjects;
    
    IBOutlet NSButton* switchLockButton;
    
    IBOutlet NSComboBox* addressedByBox;
    
    //General tab
    IBOutlet NSFormCell* cellFirstName;
    IBOutlet NSFormCell* cellLastName;
    IBOutlet NSFormCell* cellBirthday;
    IBOutlet NSFormCell* cellSex;
    IBOutlet NSFormCell* cellTel1;
    IBOutlet NSFormCell* cellTel2;
    IBOutlet NSFormCell* cellAddress;
    IBOutlet NSFormCell* cellTown;
    IBOutlet NSFormCell* cellPostalCode;
    IBOutlet NSFormCell* cellCountry;
    IBOutlet NSTextView* generalComments;
    
    //Previous history
    IBOutlet NSTextView* previousHistoryComments;
    IBOutlet NSTextView* familyHistory;
    IBOutlet NSTextView* medicalHistory;
    IBOutlet NSTextView* traumaticHistory;
    IBOutlet NSTextView* surgicalHistory;
    
    //Spheres
    IBOutlet NSTextView* entAndOphtalmologicSphere;
    IBOutlet NSTextView* dentalSphere;
    IBOutlet NSTextView* digestiveSphere;
    IBOutlet NSTextView* urinarySphere;
    
    //Consultations tab
    IBOutlet NSButton* deleteConsultationButton;
    IBOutlet NSTableView* consultationsTable;
    IBOutlet NSTableColumn* colDate;
    IBOutlet NSTableColumn* colMotives;
    
    //Documents tab
    IBOutlet NSButton* deleteDocumentButton;
    IBOutlet NSTableView* documentsTable;
    IBOutlet NSTableColumn* colDocumentTitle;
    IBOutlet NSTableColumn* colDocumentFilePath;
    
    //Mails tab
    IBOutlet NSButton* deleteMailButton;
    IBOutlet NSTableView* mailsTable;
    IBOutlet NSTableColumn* colMailName;
    IBOutlet NSTableColumn* colMailFilePath;
    
    //Appointments tab
    IBOutlet OPAppointmentPanel* appointmentPanel;
    IBOutlet NSButton* deleteAppointmentButton;
    IBOutlet NSTableView* appointmentsTable;
    IBOutlet NSTableColumn* colAppointmentDate;
    IBOutlet NSTableColumn* colAppointmentDetails;
}

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) NSArray* sortedConsultations;

@property (nonatomic) BOOL locked;
@property (nonatomic, retain) NSMutableArray* editableObjects;

@property (nonatomic, retain) IBOutlet NSButton* switchLockButton;

@property (nonatomic, retain) IBOutlet NSComboBox* addressedByBox;

@property (nonatomic, retain) IBOutlet NSFormCell*  cellFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellLastName;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellBirthday;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellSex;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTel1;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTel2;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellAddress;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellTown;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellPostalCode;
@property (nonatomic, retain) IBOutlet NSFormCell*  cellCountry;
@property (nonatomic, retain) IBOutlet NSTextView*  generalComments;

@property (nonatomic, retain) IBOutlet NSTextView* previousHistoryComments;
@property (nonatomic, retain) IBOutlet NSTextView* familyHistory;
@property (nonatomic, retain) IBOutlet NSTextView* medicalHistory;
@property (nonatomic, retain) IBOutlet NSTextView* traumaticHistory;
@property (nonatomic, retain) IBOutlet NSTextView* surgicalHistory;

@property (nonatomic, retain) IBOutlet NSTextView* entAndOphtalmologicSphere;
@property (nonatomic, retain) IBOutlet NSTextView* dentalSphere;
@property (nonatomic, retain) IBOutlet NSTextView* digestiveSphere;
@property (nonatomic, retain) IBOutlet NSTextView* urinarySphere;

@property (nonatomic, retain) IBOutlet NSButton* deleteConsultationButton;
@property (nonatomic, retain) IBOutlet NSTableView*   consultationsTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDate;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMotives;

@property (nonatomic, retain) IBOutlet NSButton* deleteDocumentButton;
@property (nonatomic, retain) IBOutlet NSTableView* documentsTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDocumentTitle;
@property (nonatomic, retain) IBOutlet NSTableColumn* colDocumentFilePath;

@property (nonatomic, retain) IBOutlet NSButton* deleteMailButton;
@property (nonatomic, retain) IBOutlet NSTableView* mailsTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMailName;
@property (nonatomic, retain) IBOutlet NSTableColumn* colMailFilePath;

@property (nonatomic, retain) IBOutlet OPAppointmentPanel* appointmentPanel;
@property (nonatomic, retain) IBOutlet NSButton* deleteAppointmentButton;
@property (nonatomic, retain) IBOutlet NSTableView* appointmentsTable;
@property (nonatomic, retain) IBOutlet NSTableColumn* colAppointmentDate;
@property (nonatomic, retain) IBOutlet NSTableColumn* colAppointmentDetails;

-(BOOL)locked;
-(void)setLocked:(BOOL)lock;
-(void)addEditableObject:(id)object;
-(void)setEditableObjectsState:(BOOL)lock;
-(IBAction)switchLock:(id)sender;


-(void)loadPatient:(OPPatient*)patientToLoad;

-(IBAction)scanDocument:(id)sender;
-(IBAction)importDocument:(id)sender;
-(IBAction)openDocument:(id)sender;
-(IBAction)deleteDocument:(id)sender;
-(void)docAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
-(void)sortConsultations;

-(IBAction)newConsultation:(id)sender;
-(IBAction)showConsultation:(id)sender;
-(IBAction)deleteConsultation:(id)sender;
-(void)consultAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;

-(IBAction)createNewMail:(id)sender;
-(IBAction)importMail:(id)sender;
-(IBAction)openMail:(id)sender;
-(IBAction)deleteMail:(id)sender;
-(void)mailAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;

-(IBAction)newAppointment:(id)sender;
-(IBAction)openCalendar:(id)sender;
-(IBAction)deleteAppointment:(id)sender;
-(void)appointmentAlertDidEnd:(NSAlert*)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
-(void)reloadAppointmentsTable;

-(void)applyModifications;
-(IBAction)savePatient:(id)sender;

@end
