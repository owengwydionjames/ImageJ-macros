//Open first image. Record and set the brightness and contrast you want for each image. 
//Input the values. Run on each open image.

dir=getDirectory("Choose a folder");    
list=getFileList(dir);

for(i=0; i<list.length; i++){
	if(endsWith(list[i],".tif") || endsWith(list[i], ".TIF")){
		open(list[i]);
	if((matches(list[i], ".*_w1.*")||(matches(list[i], ".*Channel_1.*")))){
		run("Brightness/Contrast...");
		setMinAndMax(0, 16368);
		waitForUser("Create selection and duplicate image");
		run("RGB Color");
		run("Scale Bar...", "width=1000 height=48 font=168 color=White background=None location=[Lower Right] bold hide");
		saveAs("Tiff", dir +File.separator+"w1 "+list[i]);
	}
	if((matches(list[i], ".*_w2.*")||(matches(list[i], ".*Channel_2.*")))){
		run("Brightness/Contrast...");
		setMinAndMax(469, 3655);
		run("Restore Selection");
		run("Duplicate...", " ");
		run("RGB Color");
		run("Scale Bar...", "width=1000 height=48 font=168 color=White background=None location=[Lower Right] bold hide");
		saveAs("Tiff", dir +File.separator+"w2 "+list[i]);
	}
	if((matches(list[i], ".*_w3.*")||(matches(list[i], ".*Channel_3.*")))){
		run("Brightness/Contrast...");
		setMinAndMax(114, 9642);
		run("Restore Selection");
		run("Duplicate...", " ");
		run("RGB Color");
		run("Scale Bar...", "width=1000 height=48 font=168 color=White background=None location=[Lower Right] bold hide");
		saveAs("Tiff", dir +File.separator+"w3 "+list[i]);
	}
	if((matches(list[i], ".*_w4.*")||(matches(list[i], ".*Channel_4.*")))){
		run("Brightness/Contrast...");
		setMinAndMax(107, 6696);
		run("Restore Selection");
		run("Duplicate...", " ");
		run("RGB Color");
		run("Scale Bar...", "width=1000 height=48 font=168 color=White background=None location=[Lower Right] bold hide");
		saveAs("Tiff", dir +File.separator+"w4 "+list[i]);
	}
	}
}


