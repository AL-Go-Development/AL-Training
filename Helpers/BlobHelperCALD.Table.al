table 50005 "Blob Helper ACK"
{
    Access = Public;
    Extensible = false;

    fields
    {
        field(1; "Code"; Code[1])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }

        field(2; "Blob"; Blob)
        {
            Caption = 'Blob';
            DataClassification = SystemMetadata;
        }

        field(3; Media; Media)
        {
            Caption = 'Media';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if not IsTemporary() then
            Error('Blob Helper can only be used in a temporary context.');
    end;

    procedure SetMediaFromBlob(FileName: Text)
    var
        InStr: InStream;
    begin
        CalcFields("Blob");
        "Blob".CreateInStream(InStr);
        Media.ImportStream(InStr, FileName);
    end;

    procedure FromBase64String(Input: Text; FileName: Text);
    var
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
    begin
        "Blob".CreateOutStream(OutStr);
        Base64Convert.FromBase64(Input, OutStr);

        if FileName <> '' then begin
            "Blob".CreateInStream(InStr);
            Media.ImportStream(InStr, FileName);
        end;
    end;

    procedure BlobToBase64String(): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        InStr: InStream;
    begin
        if Insert(true) then;

        CalcFields("Blob");
        "Blob".CreateInStream(InStr);
        exit(Base64Convert.ToBase64(Instr));
    end;

    procedure ToBase64String(): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
    begin
        if Insert(true) then;

        if Media.HasValue() then begin
            "Blob".CreateOutStream(OutStr);
            Media.ExportStream(OutStr);
            "Blob".CreateInStream(InStr);
            exit(Base64Convert.ToBase64(InStr));
        end;
    end;

    procedure TryDownloadFromUrl(Url: Text): Boolean
    var
        DownloadClient: HttpClient;
        DownloadHttpResponseMessage: HttpResponseMessage;
        DownloadInStream: InStream;
        DownloadOutStream: OutStream;
    begin
        if Insert(true) then;

        if DownloadClient.Get(Url, DownloadHttpResponseMessage) then
            if DownloadHttpResponseMessage.IsSuccessStatusCode() then begin
                DownloadHttpResponseMessage.Content().ReadAs(DownloadInStream);
                "Blob".CreateOutStream(DownloadOutStream);
                CopyStream(DownloadOutStream, DownloadInStream);

                Media.ImportStream(DownloadInStream, 'thumbnail.jpg');
                exit(true);
            end;

        exit(false);
    end;

    procedure ReadAsText(): Text
    var
        Output: Text;
        TextInStream: InStream;
    begin
        if Insert(true) then;

        CalcFields("Blob");
        "Blob".CreateInStream(TextInStream);
        TextInStream.ReadText(Output);
        exit(Output);
    end;

    procedure WriteAsText(Input: Text)
    var
        TextOutStream: OutStream;
    begin
        "Blob".CreateOutStream(TextOutStream);
        TextOutStream.WriteText(Input);
    end;
}
