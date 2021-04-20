<?php
/* Set e-mail recipient */
$myemail  = "omniumminecraft@gmail.com";

/* Check all form inputs using check_input function */
if (isset($_POST["name"])) {
$name = htmlspecialchars($_POST['name']);
$email = htmlspecialchars($_POST['email']);
$message = htmlspecialchars($_POST['message']);
}
else {
  echo "Could not retrieve form data.";
}
$subject = "Report From Omnium MC";

/* If input is not valid show error message */
if (!preg_match("/([\w\-]+\@[\w\-]+\.[\w\-]+)/", $email))
{
    show_error("E-mail address not valid.");
}

/* Let's prepare the message for the e-mail */
$message = "Hello,
This is a report from the Omnium Website contact form. Below is the information:

Name: $name
E-mail: $email

Message: $message

End of message
";

/* Send the message using mail() function */
mail($myemail, $subject, $message);

/* Redirect visitor to the thank you page */
echo "<script>
alert('Thanks, your report has been submitted.');
window.location.href='index.html';
</script>";
exit();

/* Functions we used */
function check_input($data, $problem='')
{
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    if ($problem && strlen($data) == 0)
    {
        show_error($problem);
    }
    return $data;
}

function show_error($myError)
{
	echo "<script>
	alert('Please correct the following error: ".$myError."');
	history.go(-1);
	</script>";
	exit();
}
?>
