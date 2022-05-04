// This macro will take a folder of .czi or .lsm files, perform a max projection, split them into separate channels and save each channel as a .tif
// For ease of sorting the images alphabetically afterwards, the filename is modified such that "C1-MAX" is added at the end of the filename 
// rather than at the start.
// owen.g.james@ed.ac.uk 25/04/22

print("\\Clear");

// ask user to select a folder
dir=getDirectory("Choose folder");    

// get the list of files (& folders) in it
fileList = getFileList(dir);

// prepare a folder to output the images
output_dir = dir + File.separator + "Single tiff files" + File.separator ;
File.makeDirectory(output_dir);

// ask user to select image type 
Dialog.create("Select image type to convert");
filetype="";
Dialog.addChoice("Filetype: ", newArray(".czi", ".lsm"));
Dialog.show();
filetype=Dialog.getChoice();

//activate batch mode
setBatchMode(true);

// LOOP to process the list of files
// for each element in the list of files, do something...
for (i = 0; i < lengthOf(fileList); i++) {

	// if the current filename of this list with the desired filetype (ie .czi or .lsm), do something else...
	if(endsWith(fileList[i],filetype)){
		
		// define the "path" 
		// by concatenation of your directory (dir) and the i element of the array fileList
		current_imagePath = dir+fileList[i];
		print(current_imagePath);
		filename=fileList[i];
		print("the filename is: ", filename);
			
			// check that the currentFile is not a directory
			if (!File.isDirectory(current_imagePath)){
			
			 // open the image and split.. 
			 // Two options for opening: if using bio-format, use the second line, otherwise, the simple (open(current_imagePath) will suffice

			 //open(current_imagePath);
			 run("Bio-Formats Windowless Importer", "open=[" + current_imagePath + "]");

			// z project, this should work regardless of whether it's a stack or not
			run("Z Project...", "projection=[Max Intensity]");

			// close others will close every window except for the front window, which will be the z projected image from previous step.
			close("\\Others");
			
			// get some info about the image
			getDimensions(width, height, channels, slices, frames);
			
			// if it's a multi channel image
			if (channels > 1) run("Split Channels");
			
				// now we save all the generated images as tif in the output_dir
				ch_nbr = nImages ; 
				
				for ( c = 1 ; c <= ch_nbr ; c++){
					selectImage(c);

					// To organise files alphabetically for downstream applications, we need to chop off "C1-MAX_" and put at the end of the name
					// Extract the name and then find how long the string is (lengthOf)
					currentImage_name = getTitle();
					Namelength = lengthOf(currentImage_name);

					// The first index of the string is the length of the string minus the length of the string
					Firstindex = Namelength - Namelength;

					// Substring the image name from the first index and the first index + 7... this covers the first 7 characters ie "C1-MAX_"
					Channelname = substring(currentImage_name, Firstindex, Firstindex+6);
					print("print the first bit", Channelname);

					// Substring the rest of the name using a similar approach except for the final three characters eg. ".czi"
					restofname = substring(currentImage_name, Firstindex+7 , Namelength -4 );

					// New file name is the original file name plus the ammended bit ("C1-MAX_") plus the desired filetype determined earlier.
					newfilename = restofname + "_" + Channelname + filetype;
					print(newfilename);

					// save the open window as a tiff in the output directory using the new filename		
					saveAs("tiff", output_dir+ File.separator+newfilename);
				}
				
		// make sure to close every images befores opening the next one
		run("Close All");
	}
}
}
setBatchMode(false);
