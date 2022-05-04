// This macro organises best projection images exported from the ImageXpress microscope.
// It transfers images across all sites from each well into individual Well+Channel subfolders (maximum 4 wavelengths).
// The macro user then selects which subfolder of images to stitch together and the fused image is displayed
// and saved in new Directory.
// This macro uses the grid coordinates to stitch tiles together. Ensure you know the grid coordinates before running macro.
// Author: Owen Gwydion James s1470204@sms.ed.ac.uk
// Dementia Research Institute, Chancellor's Building, University of Edinburgh
// 26-2-2018

dir=getDirectory("Choose ImageXpress plate folder eg.747");    
newDir=getDirectory("Where do you want to save the output images?");								
list=getFileList(dir);
listOfWell =newArray();

for(i=0; i<list.length; i++){
		if(endsWith(list[i],".tif") || endsWith(list[i], ".TIF")){
			
		//Retrieves well name from file name
		indexWell=indexOf(list[i], "_");								//Example filename = "........._A01_s1_w1.......tif"
		wellName=substring(list[i],indexWell+1,indexWell+4 );
		listOfWell = Array.concat(listOfWell, wellName);
		Array.print(listOfWell); 
}}


	// Extracting unique well name from well array (uses the sorted well array)
	sortedListOfWell=Array.sort(listOfWell);
	uniqueWell=newArray(sortedListOfWell[0]);
		for (k=1; k<sortedListOfWell.length; k++){
			if (sortedListOfWell[k] != sortedListOfWell[k-1]){
			uniqueWell=Array.concat(uniqueWell, sortedListOfWell[k]);
			Array.print(uniqueWell);
}}

	// PadZero for siteName (replaces s_1 with s_01)
	for(i=0; i<list.length; i++){
		if(endsWith(list[i],".tif") || endsWith(list[i], ".TIF")){
			indexSite=indexOf(list[i], "_s");
			indexEndSite=indexOf(list[i], "_w");
			siteName=substring(list[i],indexSite+2,indexEndSite );
			fullSiteName=substring(list[i], indexSite, indexEndSite);
			lengthOfSiteName=lengthOf(siteName);
			print(siteName);
			print(fullSiteName);
			print(lengthOfSiteName);
				if (lengthOfSiteName==1){ padZero= "0"; }
				if (lengthOfSiteName==2){ padZero= ""; }
				if (lengthOfSiteName>2){exit("Error padding zero");}
						firstPart=substring(list[i], 0, indexSite+2);
						secondPart=substring(list[i], indexSite+2, lengthOf(list[i]));
						newName=firstPart+padZero+secondPart;
						print(newName);
						File.rename(dir+list[i], dir+newName);
}}

// Identify files with different wavelengths and copy into new subfolders
m=0; i=0; j=0;
for (m=0; m<uniqueWell.length; m++){															//For each unique well name (eg.A01) process the following: 
	for(i=0; i<list.length; i++) {
		if(endsWith(list[i],".tif") || endsWith(list[i], ".TIF")){
		indexChannel=indexOf(list[i], "_w");	
		firstChannelPart=substring(list[i], 0, indexChannel+2);
		channelName=substring(list[i],indexChannel+1,indexChannel+3 );
		print(channelName);
		matchWell=".*_"+uniqueWell[m]+".*";
			if((matches(list[i], ".*_w1.*")) && (matches(list[i], matchWell) && (matches(list[i], ".*thumb.*") != 1))){   	//finds files of wavelength 1
				print(list[i]);
				newDirName=newDir+"Well_"+uniqueWell[m]+"_Channel_1";
				File.makeDirectory(newDirName);																				//Creates unique directory
				print(newDirName); 											
				File.copy(dir+list[i], newDirName+File.separator+list[i]);													//Copies files into new directory
			}
			if((matches(list[i], ".*_w2.*")) && (matches(list[i], matchWell) && (matches(list[i], ".*thumb.*") != 1))){		//Same again for wavelength 2
				print(list[i]);
				newDirName=newDir+"Well_"+uniqueWell[m]+"_Channel_2";
				File.makeDirectory(newDirName);
				print(newDirName); 	
				File.copy(dir+list[i], newDirName+File.separator+list[i]);
			}
			if((matches(list[i], ".*_w3.*")) && (matches(list[i], matchWell) && (matches(list[i], ".*thumb.*") != 1))){		//Same again for wavelength 3
				print(list[i]);
				newDirName=newDir+"Well_"+uniqueWell[m]+"_Channel_3";
				File.makeDirectory(newDirName);
				print(newDirName); 	
				File.copy(dir+list[i], newDirName+File.separator+list[i]);
			}
			if((matches(list[i], ".*_w4.*")) && (matches(list[i], matchWell) && (matches(list[i], ".*thumb.*") != 1))){		//Same again for wavelength 4
				print(list[i]);
				newDirName=newDir+"Well_"+uniqueWell[m]+"_Channel_4";
				File.makeDirectory(newDirName);
				print(newDirName); 	
				File.copy(dir+list[i], newDirName+File.separator+list[i]);
			}
		}
	}
}



// Creating a list of the Well+Channel subfolders 
	newDirlist=getFileList(newDir);	
	wellChannelList=newArray();
		for(j=0; j<newDirlist.length; j++){
			if(matches(newDirlist[j], ".*.tif.*") != 1){
			wellChannelList=Array.concat(wellChannelList, newDirlist[j]);
			Array.print(wellChannelList);
}}

print("determining the number of tiles using the number of files in the folder");
copiedList=getFileList(newDirName);
for(v=0;v<copiedList.length;v++){
if(endsWith(copiedList[v],".tif")){
	print(copiedList.length);
if(copiedList.length==9){
	Xtile = 3;        
   	Ytile = 3;
}
if(copiedList.length==12){
	Xtile = 4;        
   	Ytile = 3;
}
if(copiedList.length==16){
	Xtile = 4;        
   	Ytile = 4;
}
if(copiedList.length==20){
	Xtile = 5;        
   	Ytile = 4;
}
if(copiedList.length==25){
	Xtile = 5;        
   	Ytile = 5;
}
if(copiedList.length==30){
	Xtile = 6;        
   	Ytile = 5;
}
if(copiedList.length==36){
	Xtile = 6;        
   	Ytile = 6;
}	
}}



//else{
// Specify the grid coordinates of the image (3x3 or 3x4 or 4x4 etc...)
//		Dialog.create("What are the grid coordinates of the images you would like to stitch?"); 
//  		Dialog.addNumber("tiles across", 4); 
//   		Dialog.addNumber("tiles vertical", 4); 
//   		Dialog.show(); 
//   		Xtile = Dialog.getNumber();        
//   		Ytile = Dialog.getNumber(); 

// Choose which Well+Channel subfolder you want to process for tiled stitching

for(f=0; f<wellChannelList.length; f++){
	tempDir=newDir+wellChannelList[f];
		print("the TempDir is: "+ tempDir);
		ChoiceIndex=indexOf(tempDir, "Well");
		ChoiceNameEnd=lengthOf(tempDir);
		ChoiceName=substring(tempDir, ChoiceIndex, ChoiceNameEnd-1);						//Extracts the name of the chosen file to be used for saving stitched image
		print("the choiceName is: "+ ChoiceName);
		File.makeDirectory(tempDir);														//Creates new directory based on user choice called tempDir
		File.isDirectory(tempDir);															//Returns 1 if tempDir is a true directory
		tempList=getFileList(tempDir);
		Array.print(tempList);



			for(i=0; i<tempList.length; i++){

				// identifies the full site name and replaces with variable {ii}
				if(endsWith(tempList[i],".tif") || endsWith(tempList[i], ".TIF") && (matches(tempList[i], ".*Stitched.*") != 1)){
					currentName=tempDir+tempList[i];
					indexSiteX=indexOf(tempList[i], "_s");
					indexEndSiteX=indexOf(tempList[i], "_w");
					firstPart=substring(tempList[i], 0, indexEndSiteX+3);
					shortenedName=firstPart + ".tif";
					print("the ShortenedName is: " + shortenedName);
					newTempName=tempDir+shortenedName;
						tempSiteName=substring(tempList[i], indexSite, indexEndSite);
						genericFileName=replace(shortenedName, tempSiteName, "_s{ii}");
						File.rename(currentName, newTempName);
						print("the generic File Name is: " + genericFileName);					
				}}

				// run grid/collection stitching
						run("Grid/Collection stitching", "type=[Grid: row-by-row] order=[Right & Down                ] grid_size_x=Xtile grid_size_y=Ytile tile_overlap=10 first_file_index_i=1 directory=[&tempDir] file_names=[&genericFileName] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
						saveAs("tiff", newDir + shortenedName + "_Stitched_image" + ".tif");				
}

for(x=0; x<wellChannelList.length; x++){
	print(wellChannelList[x]);
	File.isDirectory(newDir+wellChannelList[x]+File.separator);	
	File.delete(newDir+wellChannelList[x]+File.separator);		
	File.isDirectory(newDir+wellChannelList[x]+File.separator);											
	}

