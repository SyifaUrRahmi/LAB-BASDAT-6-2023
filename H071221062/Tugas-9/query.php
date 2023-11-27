<?php
class MyQuery
{
  function __construct($conn)
  {
    $this->conn = $conn;
  }

  function show_data($input)
  {
    $arr = explode(", ", $input);
    echo "Daftar Orderan" . "\n";
    
    $sql = "SELECT DISTINCT c.customerNumber AS 'id', $input
        FROM customers c
        JOIN orders o
        USING(customernumber)
        group by $input
        ORDER BY c.customerNumber ASC
        LIMIT 5";


    $resultSet = array();
    // Jalankan Query dan Menampilkan
    $result = $this->conn->query($sql);
  
    if ($result->num_rows > 0) {
      $index = 1;
      foreach ($arr as $key => $value) {
        printf("   | %-33s", strtoupper($value));
      }
      printf("  |\n");
      while ($row = $result->fetch_array()) {
        $resultSet[$index - 1] = $row["id"];
        printf("%d.", $index);
        for($i = 0; $i < count($arr); $i++){
          printf(" | %-35s", $row[$arr[$i]]);
        }
        printf("|\n");
        $index++;
      }
    } else {
      echo "Kolom tidak tersedia";
      exit;
    }

    return $resultSet;
  }

  function update_name($kolom)
  {
    $arr = explode(", ", $kolom);

    // tampilkan nama dan pilih nama
    $list_id = $this->show_data($kolom);
    $input = -1;

      try {
        echo "Tuliskan value yang hendak kamu ubah\n";
        $input = readline('> ');
      } catch (Exception $e) {
        $input = -1;
      }

    echo 'Input Value baru';
    $new_name = readline('> ');

    $this->conn->autocommit(false);

    // Start a transaction
    $this->conn->begin_transaction();

    
    $sql_check = "SELECT $kolom FROM customers where $kolom = '$input'";
    

    $result_check = $this->conn->query($sql_check);
    
    if ($result_check->num_rows == 0) {
      echo "Value tidak tersedia pada tabel";
      exit;
    }

    // TODO [5] : masukkan query untuk mengupdate value kolom berdasarkan inputan
    $sql = "UPDATE customers SET $kolom = '$new_name' WHERE $kolom = '$input'";
    $this->conn->query($sql);
    

    echo "Daftar apa yamg kamu mau lihat" . "\n";

    $this->show_data($kolom);
    while (true) {
      echo 'Simpan Perubahan?' . "\n" . '1. YES' . "\n" . '2. NO' . "\n";
      $choice = readline('> ');
      switch ($choice) {
        case 1:
          $this->conn->commit();
          return;
        case 2:
          $this->conn->rollback();
          return;
        default:
          echo "Input Salah\n";
          break;
      }
    }
  }
 }

 
