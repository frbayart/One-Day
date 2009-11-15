<?php
$sqlcnx = mysql_connect("FIXME_HOST","FIXME_USER","FIXME_PASS") or die ("erreur connect");
/////
$sqlaa = "select `gha-mail`.`mailbox`.`username`, `gha-mail`.`mailbox`.`domain`
	from `gha-mail`.`mailbox`
	";
	//where `gha-mail`.`mailbox`.`domain`='toto.com'
	
/////
$result = mysql_query($sqlaa);
/////
if (!$result) {
    die('Requête invalide : ' . mysql_error());
}
/////

while ($row = mysql_fetch_object($result)) {
	$sqlab = "select `gha-mail`.`alias`.`address`
	from `gha-mail`.`alias`
	where `gha-mail`.`alias`.`domain`='$row->domain'
	and `gha-mail`.`alias`.`address`='$row->username'";

	$resultab = mysql_query($sqlab);

	if (!$resultab) {
	    die('Requête invalide : ' . mysql_error());
	}
	if(mysql_num_rows($resultab) == 0 )
	{
		echo "insert into `gha-mail`.`alias` set `address`='$row->username',`goto`='$row->username',`domain`='$row->domain',`created`=NOW(),`modified`=NOW(),`active`=1;\n";
	}
	mysql_free_result($resultab);

}
/////
mysql_free_result($result);
/////

mysql_close($sqlcnx);
