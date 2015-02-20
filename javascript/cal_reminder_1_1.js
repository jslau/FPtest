/*
 * Daylight Savings Time offset
 * Set calDstTime to 1 for an hour ahead, and 0 otherwise.
 */ 
var calDstOffSet = calDstTime ? 1 : 0;

// Create a new date object
var calDate = new Date();

// Get the hour offset from GMT
var calOffSet = calDate.getTimezoneOffset()/60;

// Calculate the additional offset from Daylight Savings Time.
var calRealOffSet = calOffSet + calDstOffSet;

// Default timezone
var calTimeZone = 'PST';

switch(calRealOffSet) {
	// Pacific
	case 8:
		calTimeZone = 'PST';
		calDtStart  = PSTdt[0];
		calDtEnd    = PSTdt[1];
  	break;
  			
  	// Moutain  			   
	case 7:
		calTimeZone = 'MST';
		calDtStart = MSTdt[0];
		calDtEnd   = MSTdt[1];
		break;
			
	// Central				
	case 6:
		calTimeZone = 'EST';
		calDtStart  = ESTdt[0];
		calDtEnd    = ESTdt[1];
		break;
				
	// Eastern
	case 5:
		calTimeZone = 'EST';
		calDtStart  = ESTdt[0];
		calDtEnd    = ESTdt[1];		
		break;
				
	// Default to Pacific			
	default:
		calTimeZone = 'PST';
		calDtStart  = PSTdt[0];
		calDtEnd    = PSTdt[1];
}

		
Event.observe(window, 'load', function() {
/*
 * Outlook
 */ 
	var calOItems = $$('a.caloutlook');
	if (calOItems) {
		totalCalOItems = calOItems.length;
		
		for (i=0; i<totalCalOItems; i++) {
			calOElem = $(calOItems[i]);
			calOHref = calOElem.readAttribute('href');
			calOElem.setAttribute('href', calOHref.replace('_PST', '_' + calTimeZone));
			calOElem.onclick = function() {
				pageTracker._trackPageview('/events/cal_reminders/' + calShowTrackId + '/outlook');
			}
		}
	}
	
/*
 * iCal
 */ 	
	var calIItems = $$('a.calical');
	if (calIItems) {
		totalCalIItems = calIItems.length;
		
		for (i=0; i<totalCalIItems; i++) {
			calIElem = $(calIItems[i]);
			calIHref = calIElem.readAttribute('href');
			calIElem.setAttribute('href', calIHref.replace('_PST', '_' + calTimeZone));
			calIElem.onclick = function() {
				pageTracker._trackPageview('/events/cal_reminders/' + calShowTrackId + '/ical');
			}
		}
	}
	
/*
 * Yahoo!
 */
	var calYItems = $$('a.calyahoo');
	if (calYItems) {
		totalCalYItems = calYItems.length;
		
		for (i=0; i<totalCalYItems; i++) {
			calYElem = $(calYItems[i]);
			calYHref = calYElem.readAttribute('href');
			calYHref = calYHref.replace(PSTdt[0], calDtStart);
			calYElem.setAttribute('href', calYHref);
			calYElem.onclick = function() {
				pageTracker._trackPageview('/events/cal_reminders/' + calShowTrackId + '/yahoo');
			}
		}
	}	
	
/*
 * Google
 */
	var calGItems = $$('a.calgoogle');
	if (calGItems) {
		totalCalGItems = calGItems.length;
		
		for (i=0; i<totalCalGItems; i++) {
			calGElem = $(calGItems[i]);
			calGHref = calGElem.readAttribute('href');
			calGHref = calGHref.replace(PSTdt[0], calDtStart);
			calGHref = calGHref.replace(PSTdt[1], calDtEnd);
			calGElem.setAttribute('href', calGHref);
			calGElem.onclick = function() {
				pageTracker._trackPageview('/events/cal_reminders/' + calShowTrackId + '/google');
			}
		}
	}
});