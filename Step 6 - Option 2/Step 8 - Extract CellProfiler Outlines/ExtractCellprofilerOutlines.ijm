dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Select output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(true);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".jpeg")){
  		open(inputfile);
  		name = getTitle();
  		run("RGB Color");
  		run("Split Channels");
  		selectWindow(name+" (green)");
  		rename("C2");
  		selectWindow(name+" (red)");
  		rename("C3");
  		imageCalculator("Difference create","C2","C3"); 
  		selectWindow("Result of C2");
		run("Duplicate...", " ");
		run("Invert");
		rename("Result1");
		selectWindow("Result of C2");
		setAutoThreshold("Default dark");
		run("Threshold...");
		setThreshold(21, 255);
		run("Convert to Mask");
		run("Dilate");
		run("Fill Holes");
//only watershed for CA2
		run("Watershed");
		imageCalculator("Difference create", "Result of C2", "Result1");
		selectWindow("Result of Result of C2");
		run("Invert");
		setAutoThreshold("Default dark");	
		run("Threshold...");
		setThreshold(216, 255);
		run("Convert to Mask");
		run("Fill Holes");	
		run("Erode");	
		run("Dilate");
		run("Analyze Particles...", "size=100-Infinity show=Masks display add");
		selectWindow("Result of Result of C2");
		run("16-bit");
		saveAs("tif", dir2 + filesep + "Outlines" + filelist[j]);
		if(roiManager("count")==0){
			makeRectangle(1413, 345, 15, 24);
			run("ROI Manager...");
			roiManager("Add");
			roiManager("Select", 0);
			roiManager("Rename", "Rectangle");
			roiManager("save", dir2 + filelist[j] +'_RoiSet.zip');
			roiManager("reset");
		} else{
			roiManager("save", dir2 + filelist[j] +'_RoiSet.zip');
			roiManager("reset");
		}
		close("*");
  		}
	}




	
