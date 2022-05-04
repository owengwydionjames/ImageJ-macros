// This macro renames files with an identifying experimental name + a random number.
// A .csv table is created in the output directory with the true filename

print("\\Clear");
dir=getDirectory("Select a folder of files"); 
newDir=getDirectory("select an output folder to save files");  
list=getFileList(dir);
name = "[Blind table]";

Dialog.create("Experiment name and filetype?");
identifyingname="";
filetype="";
Dialog.addString("Provide an identifying name for the experiment",identifyingname);
Dialog.addChoice("Filetype: ", newArray(".czi", ".lsm", ".tif"));
Dialog.show();
identifyingname = Dialog.getString();
filetype=Dialog.getChoice();

f = name;
makeTable();
//renameStartName();

for (i=0; i<list.length; i++){
	k=i+1;  
	filename=dir+list[i];
	newName= newDir+ identifyingname + random + filetype;
	print(f, k+"\t"+filename+"\t" +newName+"\t");
	File.copy(filename, newName);
}


function makeTable() {
name = "[Blind table]";
 run("New... ", "name="+name+" type=Table");
 f = name;
 print(f, "\\Headings:#\tfilename\tnewName\tdir\tnewDir");
}
selectWindow("Blind table");
saveAs("results", newDir +"Blinded_fileNames.csv");   //Change file name to which conditions are being blinded

