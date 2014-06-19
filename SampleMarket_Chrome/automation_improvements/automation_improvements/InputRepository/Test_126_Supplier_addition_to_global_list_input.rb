$usamp_email = "rahul_halankar@persistent.co.in"
$usamp_passwd = "rahul123"


$usnet_email = "rahul_halankar@persistent.co.in"
$usnet_passwd = "1234"
$type = "Client"


      
        $supplier_name="test_supplier"
        #puts $mail_address
        $extension = Time.new
        $extension = $extension.to_s
        $extension = $extension.slice(13..18)
        $supplier_name=$supplier_name+$extension
        #$mail_address=$MAIL+$extension+"@mailop.com"
        $supplier_name = $supplier_name.gsub(/:/, "")
        #$mail_address1 = $mail_address1.gsub(/:/, "")
        puts $supplier_name