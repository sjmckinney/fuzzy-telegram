<?php
  $dbname = 'quotesdb';
  $dbuser = 'root';
  $dbpass = 'verysecret';
  $dbhost = '172.17.0.2';

  $connect = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);

  $tblCnt = 0;
    foreach($connect->query("SHOW TABLES FROM $dbname") as $tbl) {
        echo $tbl[0]."<br />\n";
        $tblCnt++;
    }
  $connect = null;

  if (!$tblCnt) {
    echo "There are no tables<br />\n";
  } else {
    echo "There are $tblCnt tables<br />\n";
  }
?>
