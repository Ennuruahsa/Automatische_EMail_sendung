Create Or Replace Procedure Celebration(P_Mesno Messages.Mesno%Type)
is
Wpdf_Name Varchar2(100) := Null;
Font_Arialbi Pls_Integer;
WThema Messages.Thema%Type;
WMessage Messages.Message%Type;
Wmail_Sender Mailinformation.Mail_Sender%Type;
Wsmtp_Server Mailinformation.Smtp_Server%Type;
Wsmtp_Server_Port Mailinformation.Smtp_Server_Port%Type;
Wsmtp_Username Mailinformation.Smtp_Username%Type;
Wsmtp_Password Mailinformation.Smtp_Password%Type;
Woracle_Dir Mailinformation.Oracle_Dir%TYPE;

Begin
    As_Pdf3.Init;
    If P_Mesno =1 Then
        As_Pdf3.Put_image('Pdf_Dir','12345.jpg',50,100,1000,500,'left');
        wpdf_name := '12345.pdf';
    Elsif P_Mesno = 2 Then
        As_Pdf3.Put_image('Pdf_Dir','67890.jpg',50,100,1000,500,'left');
        wpdf_name := '67890.pdf';
    End If;

Font_Arialbi := As_Pdf3.Load_Ttf_Font('FONT_DIR','arialbi.ttf','CID',P_Compress => True);
As_Pdf3.Write(Wmessage,-1,750);
Select Thema,Message Into Wthema, Wmessage From Messages where Mesno= P_Mesno;
As_Pdf3.Write(Wmessage,-1,750);

As_Pdf3.Put_txt(150,200,'Alles Gute',55);

As_Pdf3.Save_Pdf(P_Filename => Wpdf_Name);

    Select Mail_Sender, Mail_Server, Smtp_Server_Port, Smtp_Username,
        Smtp_Password, Oracle_Dir Into Wmail_Sender, Wsmtp_Server, Wsmtp_Server_Port,
        Wsmtp_Username, Wsmtp_Password, Woracle_Dir from Mailinformation;

    For Lesen In (Select Kundenname, Email From Kunden Order by Kundenno) Loop
        Mail_pkg.mail_Gender(Wmail_Sender,Lesen.Email,Null,WThema,Wmessage,
        Woracle_Dir,Wpdf_Name,Wsmtp_Server,Wsmtp_Server_Port,Wsmtp_Username,
        Wsmtp_Password);
    End loop;
End;


