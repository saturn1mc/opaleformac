//
//  OPEditAppointmentView.h
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import "OPView.h"

@class OPMainWindow, OPPatient, OPAppointment, OPAppointmentPanel;

@interface OPEditAppointmentView : OPView <NSComboBoxDataSource, NSComboBoxDelegate>{
    IBOutlet NSPopover* appointmentPopOver;
    IBOutlet OPAppointmentPanel* appointmentPanel;
    BOOL locked;
    
    OPPatient* patient;
    OPAppointment* appointment;
    NSMutableArray* patients;
    
    IBOutlet NSButton* switchLockButton;
    IBOutlet NSButton* validateButton;
    IBOutlet NSButton* cancelButton;
    IBOutlet NSComboBox* patientComboBox;
    IBOutlet NSDatePicker* dayPicker;
    IBOutlet NSDatePicker* startPicker;
    IBOutlet NSDatePicker* endPicker;
    IBOutlet NSTextView* detailsText;
}

@property (nonatomic, retain) IBOutlet NSPopover* appointmentPopOver;
@property (nonatomic, retain) IBOutlet OPAppointmentPanel* appointmentPanel;
@property (nonatomic) BOOL locked;

@property (nonatomic, retain) OPPatient* patient;
@property (nonatomic, retain) OPAppointment* appointment;
@property (nonatomic, retain) NSMutableArray* patients;

@property (nonatomic, retain) IBOutlet NSButton* switchLockButton;
@property (nonatomic, retain) IBOutlet NSButton* validateButton;
@property (nonatomic, retain) IBOutlet NSButton* cancelButton;
@property (nonatomic, retain) IBOutlet NSComboBox* patientComboBox;
@property (nonatomic, retain) IBOutlet NSDatePicker* dayPicker;
@property (nonatomic, retain) IBOutlet NSDatePicker* startPicker;
@property (nonatomic, retain) IBOutlet NSDatePicker* endPicker;
@property (nonatomic, retain) IBOutlet  NSTextView* detailsText;

-(BOOL)locked;
-(void)setLocked:(BOOL)lock;
-(OPPatient*)getPatient;
-(void)setPatient:(OPPatient *)nPatient;
-(OPAppointment*)getAppointment;
-(void)setAppointment:(OPAppointment *)nAppointment;
-(IBAction)switchLock:(id)sender;
-(IBAction)checkInputs:(id)sender;
-(void)createAppointmentStarting:(NSDateComponents*)startComponents andEnding:(NSDateComponents*)endComponents;
-(IBAction)closePanel:(id)sender;
-(void)reloadPatients;

@end
