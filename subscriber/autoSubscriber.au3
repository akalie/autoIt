#include <Array.au3>


;~ OpenPage(1,2,3);
;~ 2
;~ While(True) 
;~    Sleep(10);
;~    $color = PixelGetColor(MouseGetPos(0), MouseGetPos(1));
;~    ToolTip(MouseGetPos(0) & "x" & MouseGetPos(1) & ':' & $color, MouseGetPos(0)+10 , MouseGetPos(1)+10 );
;~ WEnd
Sleep(5000);

$admins_fh  = FileOpen('c:/wrk/admins list.txt', 'r');


$row = FileReadLine($admins_fh);
while( $row )
   If( StringLeft($row, 1 ) == '#' OR $row == '') Then
	  $row = FileReadLine($admins_fh);
	  ContinueLoop;
   EndIf
   $credentials = StringSplit( $row, ' ');
;~    _ArrayDisplay($credentials);
   Authoriz(1,$credentials[1],$credentials[2]);
   ToolTip('Bot ' & $credentials[1] )
   
   $publics_fh = FileOpen('c:/wrk/publics list.txt', 'r');
   $public_id  = FileReadLine($publics_fh);
   while( $public_id )
	  If ( StringLeft($public_id, 1 ) == '#' OR $public_id == '') Then
		 $public_id = FileReadLine($publics_fh);
		 ContinueLoop;
	  EndIf
	  OpenPage($public_id);
	  ConsoleWrite($public_id & @CRLF);
	  pushJoinButton();
	  Sleep(500)
	  $public_id = FileReadLine($publics_fh);
   WEnd
   logout()
   $row = FileReadLine($admins_fh);
wend
exit;

While(True) 
   Sleep(10);
   ToolTip(MouseGetPos(0) & "x" & MouseGetPos(1), MouseGetPos(0)+10 , MouseGetPos(1)+10 );
WEnd


;~    открываем юзерскую страницу(считается, что открыт браузер и контакт на ничей регистрации)
func Authoriz( $vk_id, $login, $pass)	
   MouseClick('left',22,138,1,13);
   Sleep(200);
   ClipPut( $login );
   sleep(200);
   send('+{INSERT}');
   
   Sleep(200);
   send('{tab}');
   Sleep(200);
   
   ClipPut( $pass );
   sleep(200);
   send('+{INSERT}');
   sleep(200);
   send('{ENter}');
EndFunc

func logout()
	  Sleep(7000)
	  MouseClick('left',740,81,1,13);	
	  Sleep(7000)
EndFunc

;~ открывает страницу-паблик
func OpenPage($public_id)
   Sleep(1500);
   ConsoleWrite($public_id);
   send('{F6}');
   ClipPut( 'vk.com/club' & $public_id);
   Sleep(100);
   send('+{INSERT}');
   sleep(200);
   send('{Enter}');
   sleep(5000);
EndFunc

;~ находит и жмет кнопку "вступит в сообщество"
func pushJoinButton()
   Sleep(7000)
   MsgBox(1,1,'startLooking',1);
   $const_x  = 726
   $const_x2 = 590 
   $trig = False
   for $i = 1 to 3
	  $y = 112
	  while( $y < 564 )
		 $y = $y + 3;
		 $color  = PixelGetColor($const_x, $y)
		 $color2 = PixelGetColor($const_x2, $y)
		 $color_check = PixelGetColor($const_x, $y +30)
		 if($color == 15856113 ) then $trig = true;
		
		 if( $trig AND $color_check = 15856113 AND $color  >= 6062247 AND $color  <= 7640761 AND $color2 >= 6062247 AND $color2 <= 7640761 ) Then
			   MouseClick('left', $const_x, $y )
			   return True
		 EndIf
		 Sleep(10)
	  WEnd
	  send('{PGDN}')
	  Sleep(100)
   Next
EndFunc