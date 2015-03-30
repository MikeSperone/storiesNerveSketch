outlets = 2;

function text(tweet) {
	var newIndex = 0;
	var spaceIndex = null;
	var line = 0;
	
	for (i in tweet) {
		if (tweet[i] === " ") {
			spaceIndex = i;
			}
			
		if (i%32 == 0 && i > 0) {
			if (spaceIndex == null) {
				spaceIndex = newIndex+30;
				}
			line = line + 1;
			//outlet(0, "newIndex: "+newIndex+" spaceIndex: "+spaceIndex);
			outlet(0, line+' "'+tweet.substring(newIndex, spaceIndex)+'"');
			newIndex = spaceIndex;
			spaceIndex = null;
			outlet(1, line);
			}

		// iterate through characters find white spaces, look for 32nd character
		// choose most recent white space.  Insert a line break.
		}
	line = line+1;
	outlet(0, line+' "'+tweet.substring(newIndex, tweet.length)+'"');
	outlet(1, line)
	}