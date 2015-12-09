<?php
	
	if (isset($_POST['upload'])){


		$httpReferer = $_SERVER['HTTP_REFERER'];
		$fileError = $_FILES["uploadfile"]["error"];
		$fileName = $_FILES["uploadfile"]["name"];
		$fileRename = md5( time() . $fileName ) . ".png";
		$fileSize = $_FILES["uploadfile"]["size"];
		$fileSudffix = substr(strrchr($fileRename, "."), 1);
		$fileTempName = $_FILES["uploadfile"]["tmp_name"];
		$fileType = $_FILES["uploadfile"]["type"];
		$uploadDir = 'uploads/';
		list($width, $height) = getimagesize($_FILES["uploadfile"]["tmp_name"]);

		if($fileError > 0 ){
			echo "Upload Error" . "<br/>";
		}
		
		if(strstr($fileName, "'")){
			echo "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''' at line 23333";

		}

		if( $fileSudffix == "png" 
			&& $fileType == "image/png" 
			&& !($width == 64 && $height == 64)
			&& $fileSize < 20*1024 ){
		

			echo "Upload: " . $fileName . "<br/>";
			echo "Type: " . $fileType . "<br/>";
			echo "Size: " . ($fileSize / 1024) . "<br/>";
			echo "Temp file: " . $fileTempName . "<br/>";


			if (file_exists("uploads/" . $fileRename)){

				echo $fileRename . " is exist." . "<br/>";

			}else{


				move_uploaded_file($fileTempName, "uploads/" . $fileRename);
				
				echo "Stored in :" . "uploads/" . "renameBymd5.png" . "<br/>";

				$newWidth = 64;
				$newHeight = 64;
				
				$newImage = imagecreatetruecolor($newWidth, $newHeight);

				$imageIdentifier = imagecreatefrompng("uploads/" . $fileRename);

				imagecopyresampled($newImage, $imageIdentifier, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);

				imagepng($newImage, "uploads/" . $fileRename);

				@include("uploads/" . $fileRename);
				
			}

		}else{

			echo "Oops?! What are you doing???" . "<!-- H3i3 i5 n0 f1ag-->";
			#echo "Upload: " . $fileRename . "<br/>";
			#echo "Type: " . $fileType . "<br/>";
			#echo "Size: " . ($fileSize / 1024) . "<br/>";
			#echo "Temp file: " . $fileTempName . "<br/>";

		}

	}else{

		header("Location: index.html");

	}
