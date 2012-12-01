//
//  OPLetter.h
//  Opale
//
//  Created by Camille on 25/11/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OPConsultation, OPProfessionnal;

@interface OPLetter : NSManagedObject

@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) OPConsultation *consultation;
@property (nonatomic, retain) OPProfessionnal *professionnal;

@end
