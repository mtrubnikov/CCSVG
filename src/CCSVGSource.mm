//
//  CCSVGSource.m
//  CCSVG
//
//  Created by Luke Lutman on 12-05-22.
//  Copyright (c) 2012 Zinc Roe Design. All rights reserved.
//

#import "CCSVGSource.h"

@implementation CCSVGSource


#pragma mark 

- (id)init {
    if ((self = [super init])) {
        svg_ = boost::static_pointer_cast<MonkSVG::OpenVG_SVGHandler>(MonkSVG::OpenVG_SVGHandler::create());
    }
    return self;
}

- (id)initWithData:(NSData *)data {
    if ((self = [self init])) {
        MonkSVG::SVG parser;
        parser.initialize(svg_);
        parser.read((char *)data.bytes);
        svg_->optimize();
    }
    return self;
}

- (id)initWithFile:(NSString *)name {
	
	NSString *path;
	path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSAssert1(path, @"Missing SVG file: %@", name);
	
	NSData *data;
	data = [NSData dataWithContentsOfFile:path];
    NSAssert1(data, @"Invalid SVG file: %@", name);
	
	return [self initWithData:data];
    
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark

- (void)draw {
    svg_->draw();
}


@end