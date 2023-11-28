<?php
include 'conn.php';

$flag = (int) $_POST['flag'];

switch ($flag) {
    case 1:
        $email = $_POST['email'];
        $password = md5($_POST['password']);
        $fcm_token = $_POST['fcm_token'];

        $query = "SELECT * FROM user WHERE (Email = '$email' OR Mobile = '$email') AND Password = '$password' AND status = 1";
        $result = mysqli_query($connect, $query);

        if ($result->num_rows > 0) {
            while ($row = mysqli_fetch_assoc($result)) {
                // Update FCM Token
                $query2 = "UPDATE `user` SET `fcm_token`='$fcm_token' WHERE `id`='" . $row['id'] . "' ";
                $result2 = mysqli_query($connect, $query2);

                $json['value'] = 1;
                $json['message'] = 'User Successfully LoggedIn';
                $json['email'] = $row['Email'];
                $json['name'] = $row['Name'];
                $json['id'] = $row['id'];
                $json['status'] = 'success';
            }
        } else {
            $json['value'] = 0;
            $json['message'] = 'Failed to LogIn';
            $json['email'] = '';
            $json['name'] = '';
            $json['id'] = '';
            $json['status'] = 'failure';
        }
        break;

    case 2:
        $name = $_POST['name'];
        $email = $_POST['email'];
        $mobile = $_POST['mobile'];
        $password = md5($_POST['password']);
        $fcm_token = $_POST['fcm_token'];

        $sqlmax = "SELECT max(id) FROM `user`";
        $resultmax = mysqli_query($connect, $sqlmax);
        $rowmax = mysqli_fetch_array($resultmax);

        $idnomax = ($rowmax[0] == null) ? 1 : $rowmax[0] + 1;

        $query = "SELECT * FROM user WHERE Email='$email'";
        $result = mysqli_query($connect, $query);

        if (mysqli_num_rows($result) > 0) {
            $json['value'] = 2;
            $json['message'] = 'Email Already Used: ' . $email;
        } else {
            $query = "INSERT INTO user (id, Name, Email, Mobile, Password, fcm_token, status) VALUES ('$idnomax','$name','$email','$mobile','$password','$fcm_token', 1)";
            $inserted = mysqli_query($connect, $query);

            if ($inserted == 1) {
                $json['value'] = 1;
                $json['message'] = 'User Successfully Registered';
            } else {
                $json['value'] = 0;
                $json['message'] = 'User Registration Failed';
            }
        }
        break;

    default:
        $json['value'] = 0;
        $json['message'] = 'Invalid flag value';
}

echo json_encode($json);
mysqli_close($connect);
?>