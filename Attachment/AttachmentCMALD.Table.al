table 50004 "Attachment ACK"
{
    Access = Internal;
    Extensible = false;
    Caption = 'Attachment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Setup: Record "Setup ACK";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            begin
                if "No." <> xRec."No." then begin
                    Setup.Get();
                    Setup.TestField("Attachment Nos.");

                    NoSeriesManagement.TestManual(Setup."Attachment Nos.");
                end;
            end;
        }
        field(2; Type; Enum "Attachment Type ACK")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            Editable = false;
            TableRelation = "Car ACK";
            DataClassification = CustomerContent;
        }
        field(4; Position; Integer)
        {
            Caption = 'Position';
            DataClassification = CustomerContent;
        }
        field(5; Filename; Text[100])
        {
            Caption = 'Filename';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "File Extension"; Text[10])
        {
            Caption = 'File Extension';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Content Type"; Text[30])
        {
            Caption = 'Content Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Image Data"; Media)
        {
            Caption = 'Image Data';
            DataClassification = CustomerContent;
        }
        field(9; "Document Data"; Blob)
        {
            Caption = 'Document Data';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; "Created By"; Text[50])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; "Modified By"; Text[50])
        {
            Caption = 'Modified By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(CarNo_Position; "Car No.", Position)
        {
            MaintainSqlIndex = true;
        }
    }

    trigger OnInsert()
    var
        Attachment: Record "Attachment ACK";
        Setup: Record "Setup ACK";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            Setup.Get();
            Setup.TestField("Attachment Nos.");

            NoSeriesManagement.InitSeries(Setup."Attachment Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Attachment.SetCurrentKey(Position);
        Attachment.SetRange("Car No.", "Car No.");
        if Attachment.FindLast() then
            Position := Attachment.Position + 1
        else
            Position := 1;

        Validate("Created By", UserId());
    end;

    trigger OnModify()
    begin
        Validate("Modified By", UserId());
    end;

    internal procedure ImportFromCamera(Car: Record "Car ACK")
    begin
        ImportFromCamera(Car."No.");
    end;

    internal procedure ImportFromCamera(CarNo: Code[20])
    var
        Camera: Codeunit Camera;
        CameraInstream: InStream;
        CouldNotTakePictureErr: Label 'Could not take a picture. Does your device have a camera?';
        FileParts: List of [Text];
        FileExtension: Text;
        PictureName: Text;
    begin
        if not Camera.GetPicture(CameraInstream, PictureName) then
            Error(CouldNotTakePictureErr);

        FileParts := PictureName.Split('.');
        FileParts.Get(FileParts.Count, FileExtension);

        Init();
        Validate("Car No.", CarNo);
        Validate(Filename, CopyStr(PictureName, 1, MaxStrLen(Filename)));
        Validate("File Extension", FileExtension.ToLower());
        Validate("Content Type", 'image/jpg');
        Validate("Type", "Type"::Image);
        "Image Data".ImportStream(CameraInstream, PictureName);
        Insert(true);
    end;

    internal procedure ImportFromDevice(Car: Record "Car ACK")
    begin
        ImportFromDevice(Car."No.");
    end;

    internal procedure ImportFromDevice(CarNo: Code[20])
    var
        PictureInstream: InStream;
        CouldNotImportPictureErr: Label 'Could not import the picture.';
        DialogTitleMsg: Label 'Please select a file...';
        FileParts: List of [Text];
        FileExtension: Text;
        TempFilename: Text;
    begin
        if not UploadIntoStream(DialogTitleMsg, '', 'Image Files|*.jpg;*.jpeg;*.png', TempFilename, PictureInstream) then
            Error(CouldNotImportPictureErr);

        if TempFilename = '' then
            Error(CouldNotImportPictureErr);

        FileParts := TempFilename.Split('.');
        FileParts.Get(FileParts.Count, FileExtension);

        Init();
        Validate("Car No.", CarNo);
        Validate(Filename, CopyStr(TempFilename, 1, MaxStrLen(Filename)));
        Validate("File Extension", CopyStr(FileExtension.ToLower(), 1, MaxStrLen("File Extension")));
        Validate("Content Type", CopyStr('image/' + FileExtension.Replace('.', '').ToLower(), 1, MaxStrLen("Content Type")));
        Validate("Type", "Type"::Image);
        "Image Data".ImportStream(PictureInstream, TempFilename);
        Insert(true);
    end;
}