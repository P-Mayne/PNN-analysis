dir1 = getDirectory("Choose image input directory");
dir2 = getDirectory("Find ROI input directory");
dir3 = getDirectory("Choose output directory");
filelist = getFileList(dir1);
roilist = getFileList(dir2);
filesep = File.separator;
setBatchMode(true);
run("Set Measurements...", "area mean standard modal min perimeter median integrated display redirect=None decimal=3");

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
	if(endsWith(inputfile,".tif") || endsWith(inputfile, ".tiff")){ 
		open(inputfile);
		name = getTitle();
		name = replace(name, ".tif", "");
		for(i=0;i<roilist.length;i++){

			roisname = replace(roilist[i],"OutlinesNeuNmaskC2","C1");
			if(startsWith(roisname, name)==true){
				roiManager("Open",dir2 + roilist[i]);
				stainType = "NeuN";
			}
		}
		roinumber = roiManager("count");
		roiManager("Select All");
		roiManager("Measure");
		roiManager("reset");
		resultslength = getValue("results.count");
		for(i=1;i<roinumber+1;i++){
			setResult("ImageNumber", resultslength-i, j+1);
			setResult("StainType", resultslength-i, stainType);
		}
		close("*");
	}
}

saveAs("Results", dir3 + "Results_NeuN_17.07.csv");
close("Results");


			



	



	
