<?php

        $connection = new Mongo("mongodb://nicai:suppernicai@120.26.93.115:10000");

        $db = $connection -> HCTF;
	      $collection = $db -> login;

				$name = $_POST["name"];
				$password = $_POST["password"];
				$function = "function(){if(this.name == '$name' && this.password == '$password') return true}";
				$result = $collection->find(array('$where'=>$function));
				$check = $result->count();
				echo "<br/>";
				if ($check>0){
							echo "开心吗～233333";
				}
				else{
							echo "nonono";
				    }
?>
