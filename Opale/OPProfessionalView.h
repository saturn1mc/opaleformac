//
//  OPProfessionalView.h
//  Opale
//
//  Created by Camille on 29/06/13.
//
//

#import "OPView.h"

@class OPProfessional;

@interface OPProfessionalView : OPView <NSTextFieldDelegate, NSTextViewDelegate, NSControlTextEditingDelegate, NSComboBoxDelegate>{
    
    OPProfessional* professional;
    
    BOOL locked;
    BOOL modified;
    NSMutableArray* editableObjects;
    
    IBOutlet NSButton* switchLockButton;
    
    IBOutlet NSFormCell*   cellFirstName;
    IBOutlet NSFormCell*   cellLastName;
    IBOutlet NSFormCell*   cellSpeciality;
    IBOutlet NSFormCell*   cellTel;
    IBOutlet NSFormCell*   cellAddress;
    IBOutlet NSFormCell*   cellTown;
    IBOutlet NSComboBox*   postalCodeComboBox;
    IBOutlet NSFormCell*   cellCountry;
}

@property (nonatomic, retain) OPProfessional* professional;

@property (nonatomic) BOOL locked;
@property (nonatomic) BOOL modified;
@property (nonatomic, retain) NSMutableArray* editableObjects;

@property (nonatomic, retain) IBOutlet NSButton* switchLockButton;

@property (nonatomic, retain) IBOutlet NSFormCell*   cellFirstName;
@property (nonatomic, retain) IBOutlet NSFormCell*   cellLastName;
@property (nonatomic, retain) IBOutlet NSFormCell*   cellSpeciality;
@property (nonatomic, retain) IBOutlet NSFormCell*   cellTel;
@property (nonatomic, retain) IBOutlet NSFormCell*   cellAddress;
@property (nonatomic, retain) IBOutlet NSFormCell*   cellTown;
@property (nonatomic, retain) IBOutlet NSComboBox*   postalCodeComboBox;
@property (nonatomic, retain) IBOutlet NSFormCell*   cellCountry;

-(IBAction)switchLock:(id)sender;
-(BOOL)locked;
-(void)setLocked:(BOOL)lock;
-(void)addEditableObject:(id)object;
-(void)setEditableObjectsState:(BOOL)lock;

-(void)loadProfessional:(OPProfessional*)professionalToLoad;
-(void)applyModifications;
-(IBAction)saveProfessional:(id)sender;

@end
