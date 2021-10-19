page 50007 "Attachment Drop Factbox ACK"
{
    Extensible = false;

    PageType = CardPart;
    Caption = 'Drag & Drop Attachments';

    layout
    {
        area(content)
        {
            usercontrol(Addin; "Drag Drop Addin ACK")
            {
                ApplicationArea = All;

                trigger DataRead(DroppedFile: JsonObject)
                begin
                    Save(DroppedFile);
                end;
            }
        }
    }

    local procedure Save(DroppedFile: JsonObject)
    var
        Attachment: Record "Attachment ACK";
        TempBlobHelper: Record "Blob Helper ACK" temporary;
        JSONHelper: Codeunit "JSON Helper ACK";
        ImageAddedNotification: Notification;
        Base64Content: Text;
        ContentType: Text;
        FileExtension: Text;
        FileName: Text;
    begin
        FileName := JSONHelper.GetTextValue(DroppedFile, 'Filename');
        FileExtension := JSONHelper.GetTextValue(DroppedFile, 'FileExtension');
        ContentType := JSONHelper.GetTextValue(DroppedFile, 'ContentType');
        Base64Content := JSONHelper.GetTextValue(DroppedFile, 'Data', 0);

        if Base64Content <> '' then begin
            TempBlobHelper.Init();
            TempBlobHelper.FromBase64String(Base64Content, FileName);

            Attachment.Init();
            Attachment.Validate("Car No.", gCarNo);
            Attachment.Validate(Filename, CopyStr(FileName, 1, MaxStrLen(Attachment.Filename)));
            Attachment.Validate("File Extension", CopyStr(FileExtension.ToLower(), 1, MaxStrLen(Attachment."File Extension")));
            Attachment.Validate("Content Type", CopyStr(ContentType, 1, MaxStrLen(Attachment."Content Type")));
            if ContentType.StartsWith('image') then begin
                Attachment.Validate("Type", Attachment."Type"::Image);
                Attachment.Validate("Image Data", TempBlobHelper.Media);
            end else begin
                Attachment.Validate("Type", Attachment."Type"::Document);
                Attachment.Validate("Document Data", TempBlobHelper.Blob);
            end;
            Attachment.Insert(true);

            if gShowFeedback then begin
                ImageAddedNotification.Message := StrSubstNo(ImageAddedMsg, Attachment.Filename);
                ImageAddedNotification.Scope := NotificationScope::LocalScope;
                ImageAddedNotification.Send();
            end;

            CurrPage.Update(false);
        end;
    end;

    internal procedure SetFilters(CarNo: Code[20]; ShowFeedback: Boolean)
    begin
        gCarNo := CarNo;
        gShowFeedback := ShowFeedback;
    end;

    var
        gShowFeedback: Boolean;
        gCarNo: Code[20];
        ImageAddedMsg: Label 'Image %1 added succesfully.', Comment = '%1=File name';
}