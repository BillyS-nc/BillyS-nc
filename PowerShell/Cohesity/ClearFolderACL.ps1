


$acl = Get-Acl "\\sbch-dp03br.sigi.us.selective.com\sql_prod3_TEST_ACLs\CL045SQLA"
$acl.Access | %{$acl.RemoveAccessRule($_)}


#$path = "\\sbch-dp03br.sigi.us.selective.com\sql_prod3_TEST_ACLs\CL045SQLA"


#$AddAccessRule = New-Object 'security.accesscontrol.filesystemaccessrulE'("CREATOR OWNER",@("ReadAndExecute,Synchronize"),"ContainerInherit,Objectinherit","Inheritonly","Allow")
#$objacl = get-acl "\\sbch-dp03br.sigi.us.selective.com\sql_prod3_TEST_ACLs\CL045SQLA"
#$ObjAcl.AddAccessRule($AddAccessRule)
#set-acl -path "\\sbch-dp03br.sigi.us.selective.com\sql_prod3_TEST_ACLs\CL045SQLA" $objacl