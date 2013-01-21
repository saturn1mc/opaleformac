//
//  OPAppointmentPanel.h
//  Opale
//
//  Created by Camille on 16/01/13.
//
//

#import <Cocoa/Cocoa.h>

@class OPMainWindow, OPPatient;

@interface OPAppointmentPanel : NSPanel<NSComboBoxDataSource, NSComboBoxDelegate>{
    IBOutlet OPMainWindow* parent;
    BOOL locked;
    OPPatient* patient;
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

@property (nonatomic, retain) IBOutlet OPMainWindow* parent;
@property (nonatomic) BOOL locked;
@property (nonatomic, retain) OPPatient* patient;
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
-(IBAction)switchLock:(id)sender;
-(IBAction)exitPanel:(id)sender;
-(void)reloadPatients;

@end
