<?php
	/* Hier werden die Daten aus dem Formular in Variablen geschrieben */
	$gender=$_GET['gender'];
	$fname=$_GET['firstname'];
	$name=$_GET['lastname'];
	$mail=$_GET['email'];
	$topic=$_GET['topics'];


	/* Datenbankanbindung */

	/* Datenbankobjekt erstellen: Server, User, Passwort und Datenbanknamen eingeben (direkt wie hier oder wahlweise als Variablen */
	$mysqli = new mysqli('localhost', 'Carmen', 'local1234', 'newsletter_db');
	
	/* Fehler? 
	Dann über Fehlernummer (errno) den Fehlertext ausgeben lassen (error). Wird im weiteren Verlauf der Einfachheit halber weggelassen */
	if ($mysqli->connect_errno) {
		echo 'Fehler: '.$mysqli->connect_error;
	}
	/* Wird unter der Adresse schon ein Newsletter verschickt? 
	Funktion mail_exists() überprüft, ob in der Tabelle user_tbl eine identische E-Mail-Adresse hinterlegt ist. Der Rückgabewert ist ein boolean (Wahrheitswert). */
	if(!mail_exists($mysqli, $mail, $gender, $fname)){
		/* Gibt es diese Mail-Adresse noch nicht, können die Werte in die Tabellen mit der Funktion insert_data() eingefügt werden */
		insert_data($mysqli, $gender, $fname, $name, $mail, $topic);
	}


	/* Funktion, die überprüft, ob schon ein Datenbankeintrag zu dieser E-Mail-Adresse exisitiert */
	function mail_exists($mysqli, $m, $g, $fn){
		/* Prepared Statement: Anfrage vorbereiten, konkrete Werte (php-Variablen) aber noch nicht einsetzten (SQL-injection vorbeugen).*/
		$stmt=$mysqli->prepare("SELECT * FROM user_tbl WHERE `email`=?"); /* SQL-Select */
		$stmt->bind_param("s", $m); /* Parameter binden */
		$stmt->execute();	/* Anfrage ausführen */
		$result=$stmt->get_result(); /* Ergebnis speichern */
		$exists=false;	/* Variable mit boolschem Wert zur (non)existenten E-Mail in der DB */
		while ($result->fetch_assoc()) {
			$exists=true;	/* Sobald ein Wert gefunden wurde, wird Wert auf true gesetzt, denn dann wurde irgendein Eintrag zur identischen E-Mail entdeckt. */
			break;	/* Schleife kann abgebrochen werden, da uns der konkrete Inhalt nicht interessiert. */
		}
		/* Wenn es keinen Eintrag gibt, zurück mit Rückgabewert, ansonsten kommt eine Meldung */
		if(!$exists){
			echo "Die Adresse ".$m." wurde noch nicht angelegt.";
			return $exists;
		}
		/* Rückmeldung bei existenter E-Mail-Adresse */
		else{
			if($g=="m") echo "<br>Lieber ";
			else if($g=="w") echo "<br>Liebe ";
			else echo "<br> Hallo ";
			echo " ".$fn."<br>unter: ".$m." wurde bereits ein Newsletter abonniert.<br> Bitte versuche es mit einer anderen E-Mail-Adresse erneut.";
			return $exists;
		}

	}

	function insert_data($mysqli, $g, $fn, $n, $m, $t){
		$stmt=$mysqli->prepare("INSERT INTO `user_tbl` (`gender`,`firstname`,`name`,`email`) VALUES (?, ?, ?, ?)");
		$stmt->bind_param("ssss", $g, $fn, $n, $m);
		$stmt->execute();
		
		$stmt=$mysqli->prepare("SELECT `user_id` FROM `user_tbl` WHERE `email`=?");
		$stmt->bind_param("s", $m);
		$stmt->execute();
		$result=$stmt->get_result();
		$uid=0;
		while ($obj = $result->fetch_object()) {
    		$uid=$obj->user_id;
    	}

		foreach($t as $t){
			$stmt=$mysqli->prepare("INSERT INTO newsletter_tbl (`user`, `topic`) VALUES (?, ?)");
			$stmt->bind_param("ss", $uid, $t);
			$stmt->execute();
		}
		echo "<br>Ihre Daten wurden eingetragen.";
	}
?>
