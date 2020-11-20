<?php

	$code=$_POST["code"];
	$input=$_POST["input"];
	// $json = json_decode($_POST['code']);
	// $code = $json->Code;
	// $input = $json->Input;
	$filename_code="temp.c";
	$filename_in="input.txt";
	$filename_error="error.txt";
	$executable="a.exe";
	$command="gcc -lm ".$filename_code;	
	$command_error=$command." 2>".$filename_error;	


	$file_code = fopen($filename_code, "w+");
	fwrite($file_code, $code);
	fclose($file_code);
	$file_in=fopen($filename_in,"w+");
	fwrite($file_in,$input);
	fclose($file_in);

	shell_exec($command_error);
	$error=file_get_contents($filename_error);
	if(empty($error)){

		if(!empty($input)){
			shell_exec(".\\".$executable." < ".$filename_in." 2> ".$filename_error);
			$error= file_get_contents($filename_error);
			if (empty($error)) {
				$output=shell_exec(".\\".$executable." < ".$filename_in);
			}
		}
		else{
			shell_exec(".\\".$executable." 2> ".$filename_error);
			$error = file_get_contents($filename_error);
			if (empty($error)){
				$output=shell_exec(".\\".$executable);
			}
		}
	}
	if(isset($output))
		$arr = array("Output" => $output, "Error" => $error);
	else
		$arr = array("Output" => null, "Error" => $error);
	header('Content-Type: application/json');
	echo json_encode($arr);
	
	if(file_exists($filename_code)){
		unlink($filename_code);
	}
	if(file_exists($filename_in)){
		unlink($filename_in);
	}
	if(file_exists($filename_error)){
		unlink($filename_error);
	}
	if(file_exists($executable)){
		unlink($executable);
	}

?>