//
//  OPMainWindow.h
//  Opale
//
//  Created by Camille on 06/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class OPView, OPPatient, OPConsultation, OPProfessional, OPMail, OPDocument, OPPatientsView, OPCalendarView, OPAdultMalePatientView, OPAdultFemalePatientView, OPBabyPatientView, OPConsultationView, OPProfessionalsView, OPProfessionalView, OPScanningView;

@interface OPMainWindow : NSWindow {
    
    IBOutlet NSToolbarItem* nextButton;
    IBOutlet NSToolbarItem* previousButton;
    
    NSScrollView* currentScrollView;
    OPView* currentView;
    
    IBOutlet OPView* homeView;
    IBOutlet OPPatientsView* patientsView;
    IBOutlet OPCalendarView* calendarView;
    IBOutlet OPView* accountingView;
    IBOutlet OPView* statsView;
    IBOutlet OPProfessionalsView* professionalsView;
    
    IBOutlet OPAdultMalePatientView* adultMalePatientView;
    IBOutlet OPAdultFemalePatientView* adultFemalePatientView;
    IBOutlet OPConsultationView* consultationView;
    
    IBOutlet OPProfessionalView* professionalView;
    
    IBOutlet OPScanningView* scanningView;
    
    CATransition* transition;
}

@property (nonatomic, retain) IBOutlet NSToolbarItem* nextButton;
@property (nonatomic, retain) IBOutlet NSToolbarItem* previousButton;


@property (nonatomic, retain) NSScrollView* currentScrollView;
@property (nonatomic, retain) OPView* currentView;

@property (nonatomic, retain) IBOutlet OPView* homeView;
@property (nonatomic, retain) IBOutlet OPPatientsView* patientsView;
@property (nonatomic, retain) IBOutlet OPCalendarView* calendarView;
@property (nonatomic, retain) IBOutlet OPView* accountingView;
@property (nonatomic, retain) IBOutlet OPView* statsView;
@property (nonatomic, retain) IBOutlet OPProfessionalsView* professionalsView;

@property (nonatomic, retain) IBOutlet OPAdultMalePatientView* adultMalePatientView;
@property (nonatomic, retain) IBOutlet OPAdultFemalePatientView* adultFemalePatientView;
@property (nonatomic, retain) IBOutlet OPBabyPatientView* babyPatientView;

@property (nonatomic, retain) IBOutlet OPConsultationView* consultationView;

@property (nonatomic, retain) IBOutlet OPProfessionalView* professionalView;

@property (nonatomic, retain) IBOutlet OPScanningView* scanningView;

@property (nonatomic, retain) CATransition* transition;

-(NSURL*)directoryFor:(OPPatient*)patient;
-(NSURL*)mailDirectoryFor:(OPPatient*)patient;
-(NSURL*)documentDirectoryFor:(OPPatient*)patient;

-(void)openMail:(OPMail*)mail;
-(void)openDocument:(OPDocument*)document;
-(void)openCalendarAtDate:(NSDate *)date;

-(IBAction)showHomeView:(id)sender;
-(IBAction)showPatientsView:(id)sender;
-(IBAction)showCalendarView:(id)sender;
-(IBAction)showAccountingView:(id)sender;
-(IBAction)showStatsView:(id)sender;
-(IBAction)showProfessionalsView:(id)sender;

-(IBAction)showProfessionalViewFor:(OPProfessional*)professional;
-(IBAction)showProfessionalViewFor:(OPProfessional*)professional withLockState:(BOOL)locked;

-(IBAction)showPatientViewFor:(OPPatient*)patient;
-(IBAction)showPatientViewFor:(OPPatient*)patient withLockState:(BOOL)locked;
-(IBAction)showConsultationViewFor:(OPConsultation*)consultation;

-(IBAction)showScanningView:(id)sender;

-(void)pushSubview:(OPView *)newView;
-(void)fadeSubview:(OPView *)newView;

-(IBAction)previousView:(id)sender;
-(IBAction)nextView:(id)sender;

-(void)openNewView:(OPView*)newView;
-(void)openNewView:(OPView *)newView withReset:(BOOL)reset;
-(void)switchView:(OPView*)newView;
-(void)switchView:(OPView *)newView withReset:(BOOL)reset;

@end
